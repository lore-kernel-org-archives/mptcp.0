Received: from ma-mailsvcp-mx-lapp01.apple.com (ma-mailsvcp-mx-lapp01.apple.com [17.32.222.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74E64A
	for <mptcp@lists.linux.dev>; Thu,  9 Feb 2023 17:57:02 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) with ESMTPS id <0RPT006PDOEP5U30@ma-mailsvcp-mx-lapp01.apple.com> for
 mptcp@lists.linux.dev; Thu, 09 Feb 2023 08:56:54 -0800 (PST)
X-Proofpoint-GUID: YkHxXr6HX0HJ-4HskAX_TNBdf7mxE8yW
X-Proofpoint-ORIG-GUID: YkHxXr6HX0HJ-4HskAX_TNBdf7mxE8yW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.562,18.0.930
 definitions=2023-02-09_13:2023-02-09,2023-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=dhz0oHmIHoJjwtjOABLUTFZGvWPAzi+qCt+wt19+Fc0=;
 b=oomK7ayg1GQf/+pt8S9Vjmsl2Xl8TOGqvi1fKHGgXs6zOp8V7pajmBA5wKEVwqfxVhIq
 IyaO2/vumi3hY2fGIZrdU/vofzoZUNINDodz+KhfyYPwyhbv5o9ByeeW5OTUiRiMkWLB
 V1BiTIQujvdAr7Th6wMHJu9JzS0QRU9JGL/7pIjxqEc9+Crh8Nuqwc8QuhcR/lA4wVcC
 lL7h2MALsXMy+T1Ya3UHlkvtJXKfTNtObc/43W8LOV6+G2U1w24rF8EKdtgGZjCrsHGd
 Mti2rbJwqF9e4IjXt4n6qZ+y8rwjpHciH7fOeQHNh8fMDSt9c+jm3wvFxOGFGzDKpE+v tw==
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) with ESMTPS id <0RPT005PTOERFYE0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Thu, 09 Feb 2023 08:56:51 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) id <0RPT00W00OAHP900@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Thu,
 09 Feb 2023 08:56:51 -0800 (PST)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 2d0f2c043516c8e8e7cf6dd2d1b137a6
X-Va-R-CD: f3dd1c712c7ef6cceebdf54c81f041cd
X-Va-ID: 119bad5f-0de6-4e71-94dd-706fd90a1dd8
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 2d0f2c043516c8e8e7cf6dd2d1b137a6
X-V-R-CD: f3dd1c712c7ef6cceebdf54c81f041cd
X-V-ID: 962214b5-aaf8-4a19-9658-c14b84a95d68
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.562,18.0.930
 definitions=2023-02-09_13:2023-02-09,2023-02-09 signatures=0
Received: from smtpclient.apple (unknown [17.11.232.191])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022))
 with ESMTPSA id <0RPT005K6OEQOL00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Thu,
 09 Feb 2023 08:56:51 -0800 (PST)
Content-type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.500.161\))
Subject: Re: [PATCH mptcp-net 0/2] mptcp: tentative fix for issues246 &&
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <cover.1675892307.git.pabeni@redhat.com>
Date: Thu, 09 Feb 2023 08:56:40 -0800
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: 7bit
Message-id: <0EA98E95-85C9-433B-8A57-260CC8FA8379@apple.com>
References: <cover.1675892307.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.500.161)



> On Feb 8, 2023, at 1:44 PM, Paolo Abeni <pabeni@redhat.com> wrote:
> 
> Sharing these very early, because I can't reproduce the issues locally.
> Even the commit messages are early draft.
> 
> @Christoph could you please check the relevant repros here?
> 
> I *think* there still some refcount problem to address in the new code,
> any sharp eyes more then welcome ;)
> 
> Targeting -net even if bases on top of corrent mptcp-next, as
> the merge window is almost imminent.
> 
> Paolo Abeni (2):
>  mptcp: use the workqueue to destroy unaccepted sockets.
>  mptcp: fix UaF in listener shutdown
> 
> net/mptcp/protocol.c | 27 ++++++++-----
> net/mptcp/protocol.h |  4 +-
> net/mptcp/subflow.c  | 91 +++++---------------------------------------
> 3 files changed, 28 insertions(+), 94 deletions(-)

I was able to get a new reproducer for a UaF read in subflow_error_report.

Your patches (with the schedule-work fix) indeed fix the KASAN-issue.

Tested-by: Christoph Paasch <cpaasch@apple.com>


Christoph

