Received: from ma1-aaemail-dr-lapp02.apple.com (ma1-aaemail-dr-lapp02.apple.com [17.171.2.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB393214
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 21:00:15 +0000 (UTC)
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
	by ma1-aaemail-dr-lapp02.apple.com (8.16.0.42/8.16.0.42) with SMTP id 2B9KtJ3h025357;
	Fri, 9 Dec 2022 12:59:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=6KgC/yyI3MlWpnAS0XXhlN2VUm/mv3t9SdjD0XJgZ8U=;
 b=kf6Is1Qtr0KDlur6VRrS1E6I+K40SIVJyU2dKTC1YykAXqW51jJBPI/nQa6hTtrSRtuX
 Z3K0lCMGrTNHC9j86pgxsHdF7sdHpTWmzoWJvJu8QL8WhSQPWSCm3JukeJ36yESUYFvt
 jGqYavNB17Z/3ThUTeGSveSOQKnKNh9WgA81RIW+NxBlw6jcc681rT+fKfpM2EVXkwfv
 BeMhN2phb831saDwgV4hr7gQXN4Xz5COPSy51UduwBl8dAsGxLkdnp3qLMgAQ8MmeZFy
 pM7PvJXOZ0auVO1JQUpjHCpUBfKSQOdRyCKqFH7kNIyquYhFnB6ExsqBI5stzPAFR+TI fA== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
	by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 3m840xamua-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Fri, 09 Dec 2022 12:59:46 -0800
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) with ESMTPS id <0RMN011IX6BM35F0@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Fri, 09 Dec 2022 12:59:46 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) id <0RMN00R0063FL300@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Fri,
 09 Dec 2022 12:59:46 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 14b2d5c3db080b9848858d1403c630a3
X-Va-E-CD: 62fa154b3404cb416ed0dfc74082188d
X-Va-R-CD: d92cb93a1eacc737d1c3bb0a40816e31
X-Va-CD: 0
X-Va-ID: 6da67af7-beb5-4a8b-956d-19ec274392d1
X-V-A: 
X-V-T-CD: 14b2d5c3db080b9848858d1403c630a3
X-V-E-CD: 62fa154b3404cb416ed0dfc74082188d
X-V-R-CD: d92cb93a1eacc737d1c3bb0a40816e31
X-V-CD: 0
X-V-ID: 63b64e5e-d2eb-4a8a-bcea-abc4d7154da0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.545,18.0.923
 definitions=2022-12-09_11:2022-12-08,2022-12-09 signatures=0
Received: from smtpclient.apple (unknown [17.192.155.203])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022))
 with ESMTPSA id <0RMN00FC96BLV800@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Fri,
 09 Dec 2022 12:59:45 -0800 (PST)
Content-type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.1\))
Subject: Re: [Weekly meetings] Change day/hour?
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
Date: Fri, 09 Dec 2022 12:59:35 -0800
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Ossama Othman <ossama.othman@intel.com>,
        Davide Caratti <dcaratti@redhat.com>, Florian Westphal <fw@strlen.de>,
        Benjamin Hesmans <benjamin.hesmans@tessares.net>,
        Dmytro Shytyi <dmytro@shytyi.net>,
        Geliang Tang <geliang.tang@suse.com>
Content-transfer-encoding: quoted-printable
Message-id: <83A89A51-B913-4F38-A2C6-A4674A215865@apple.com>
References: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: Apple Mail (2.3731.300.101.1.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.545,18.0.923
 definitions=2022-12-09_11:2022-12-08,2022-12-09 signatures=0

Hello,

Thursdays is not possible for me. I can make the other days work, =
starting at 8h30am.


Christoph


> On Dec 8, 2022, at 9:51 AM, Matthieu Baerts =
<matthieu.baerts@tessares.net> wrote:
>=20
> Hello,
>=20
> At the last meeting, we discussed the idea of re-scheduling the weekly
> meetings we have because some people might not be able to join or =
prefer
> another moment.
>=20
> But because we were exceptionally only 3 today because of the feast of
> the Immaculate Conception, we didn't take any decision. Instead, we
> would then like to hear from people who want to participate to know =
what
> they think about eventually:
>=20
> - Changing the day to Tuesday?
>  - It might be better to avoid Monday (morning) and Friday (evening).
>  - Wednesday was not OK for today's participants
>=20
> - Changing the time to have it one hour later?
>  - It means 17:00 UTC (9am PST, 6pm CET, 1am CST)
>  - This is late for people in China but midnight is late anyway
>  - Maybe we can also schedule less frequent meetings at a different
> time (or on request), e.g. morning in Europe, afternoon in China?
>  - (the BPF weekly meetings are on Thursdays at 17:00 UTC)
>=20
> What would be OK or not OK for you? Tuesday or Thursday, same time or
> one hour later?
>=20
> Thanks,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>=20

