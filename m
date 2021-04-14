Received: from rn-mailsvcp-ppex-lapp14.apple.com (rn-mailsvcp-ppex-lapp14.rno.apple.com [17.179.253.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911D6D32
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 17:49:37 +0000 (UTC)
Received: from pps.filterd (rn-mailsvcp-ppex-lapp14.rno.apple.com [127.0.0.1])
	by rn-mailsvcp-ppex-lapp14.rno.apple.com (8.16.1.2/8.16.1.2) with SMTP id 13EH3Rvp013508;
	Wed, 14 Apr 2021 10:03:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180706; bh=bJjGdM888wnQGpAkOxUpzHNjOMYzBmpN4eHL9BMUNl4=;
 b=fuPunzRqnCTLw2j+CgY6u1r7Ek5Qmz372/KRsCBTengH65xKQnSPpXf+t+f9AuE3tIug
 yyLpczfAEUx/GeGI7QXWx6NXoRCgoXaY5Tv/P64wcXezvy8phFS02vcgwyIcLdfA1xpU
 HwjQ31c+2IxRCm+300masLQG0n3i7ksb53HJgY/rdTJU/PzAIWLtN9QTdZLmUy8N10pa
 6P2CLP4Mph3R8QJLKvOcg3W+yxWp/I1NCHsC2+JZqcLXUnVaqEDQbU04YDXEfbyHCPWy
 CY0DEzrAQx4/8WXnvir9lhU+e8havs12of2o7v3kWwc2U6Lt/PHQFgSicugaJjo/OkV9 fQ== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
	by rn-mailsvcp-ppex-lapp14.rno.apple.com with ESMTP id 37u8wbdnem-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 14 Apr 2021 10:03:28 -0700
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.7.20201203 64bit (built Dec  3
 2020)) with ESMTPS id <0QRK0113TCPQQO70@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Wed, 14 Apr 2021 10:03:26 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.7.20201203 64bit (built Dec  3
 2020)) id <0QRK00O00COH3300@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 14 Apr 2021 10:03:26 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 14b2d5c3db080b9848858d1403c630a3
X-Va-E-CD: 9b0de5c0cefe224ea7f69f68417f168d
X-Va-R-CD: 5a5adb75ad4b1905f4cd4a6a1d5fad0c
X-Va-CD: 0
X-Va-ID: 40176fdc-6b53-46f5-88b5-959445ad63e3
X-V-A: 
X-V-T-CD: 14b2d5c3db080b9848858d1403c630a3
X-V-E-CD: 9b0de5c0cefe224ea7f69f68417f168d
X-V-R-CD: 5a5adb75ad4b1905f4cd4a6a1d5fad0c
X-V-CD: 0
X-V-ID: 26c958c0-808f-4bae-8812-359ae3a1ea08
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_10:2021-04-14,2021-04-14 signatures=0
Received: from localhost ([17.234.73.16])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.7.20201203 64bit (built Dec  3
 2020))
 with ESMTPSA id <0QRK00B89CPP3S00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 14 Apr 2021 10:03:25 -0700 (PDT)
Date: Wed, 14 Apr 2021 10:03:25 -0700
From: Christoph Paasch <cpaasch@apple.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: Weekly meeting - 15 April 2021 15:00 UTC (8am PDT, 5pm CEST,
 11pm CST)
Message-id: <YHcgXdMvuX4xsIh5@MacBook-Pro.local>
References: <e1d0b3b9-eed8-06dc-b26f-a3ad9ead93c4@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <e1d0b3b9-eed8-06dc-b26f-a3ad9ead93c4@tessares.net>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_10:2021-04-14,2021-04-14 signatures=0

Hello,

I have a conflicting meeting and won't be able to attend this week's weekly.


Christoph

On 04/14/21 - 18:31, Matthieu Baerts wrote:
> Hello everybody!
> 
> Our public MPTCP upstreaming weekly web conference is scheduled for
> tomorrow.
> 
> The list of topics is available here:
> https://annuel2.framapad.org/p/mptcp_upstreaming_20210415
> 
> Feel free to add/modify topics!
> 
> Anybody can join the meeting using Google Meet website/app/phone:
> https://meet.google.com/edk-rkrk-vaj
> 
> See/Speak to you tomorrow!
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 
