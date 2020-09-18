Content-Type: multipart/mixed; boundary="===============4963362463238441693=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Request for net merge into net-next
Date: Fri, 18 Sep 2020 16:20:00 +0200
Message-ID: <07cc0dc2-f789-fc5f-b0e8-88daa249ffbd@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5932

--===============4963362463238441693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi David, Jakub,

We have a few net-next MPTCP changes depending on:

- 57025817eaa4 ("mptcp: fix subflow's local_id issues")
- 2ff0e566faa4 ("mptcp: fix subflow's remote_id issues")
- f612eb76f349 ("mptcp: fix kmalloc flag in mptcp_pm_nl_get_local_id")

We guess you are going to send a pull request for 'net' to Linus soon =

and sync everything once it is done. But just in case, if not, could you =

please merge 'net' into 'net-next' so that we can post without causing =

conflicts later and issues in tests?

Thank you!

Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4963362463238441693==--
