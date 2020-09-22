package log;

import java.util.ArrayList;
import java.io.*;

public class LogDAO {

	public ArrayList<LogVO> getLogAll() {//로그 전체 반환

		ArrayList<LogVO> list = new ArrayList<LogVO>();

		try {
			// 파일 객체 생성
			File file = new File("C:\\Users\\안병욱\\Desktop\\java\\se_editor\\log.txt");// 절대경로 사용할것
			// 입력 스트림 생성
			FileReader filereader = new FileReader(file);
			// 입력 버퍼 생성
			BufferedReader bufReader = new BufferedReader(filereader);
			String line = "";
			
			//첫 두줄 가비지 값이므로 넘기고 시작.
			line = bufReader.readLine();
			line = bufReader.readLine();
			
			while ((line = bufReader.readLine()) != null) {
				LogVO vo = new LogVO();

				String[] tmp = line.split("/");
				vo.setId(tmp[0]);
				vo.setId2(tmp[1]);
				vo.setSession1(tmp[2]);
				vo.setSession2(tmp[3]);
				vo.setContainerId(tmp[4]);
				vo.setLanguage(tmp[5]);
				vo.setResult(tmp[6]);

				list.add(vo);
			}

			bufReader.close();

			return list;
		} catch (FileNotFoundException e) {
			System.out.println(e);
		} catch (IOException e) {
			System.out.println(e);
		}
		return list;
	}
	
	public ArrayList<LogVO> getLogById(String id){//id값에 맞는 로그 반환
		
		ArrayList<LogVO> tmpList = new ArrayList<LogVO>(getLogAll());
		ArrayList<LogVO> list = new ArrayList<LogVO>();
		
		for(int i=0; i<tmpList.size(); i++)
			if(id.equals(tmpList.get(i).getId().replace(" ","")))
			{
				LogVO tmp = tmpList.get(i);
				
				list.add(tmp);
			}
		
		return list;
	}
	
	public ArrayList<LogVO> getLogByLanguage(String language){
		
		ArrayList<LogVO> tmpList = new ArrayList<LogVO>(getLogAll());
		ArrayList<LogVO> list = new ArrayList<LogVO>();
		
		for(int i=0; i<tmpList.size(); i++)
			if(language.equals(tmpList.get(i).getLanguage().replace(" ", "")))
			{
				LogVO tmp = tmpList.get(i);
				
				list.add(tmp);
			}
		
		return list;
	}
}
