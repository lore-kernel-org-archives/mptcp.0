Content-Type: multipart/mixed; boundary="===============2045539899469460565=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] net: mptcp: don't hang in
 mptcp_sendmsg() after TCP fallback
Date: Mon, 23 Mar 2020 20:53:34 -0700
Message-ID: <20200323.205334.1556861946836251963.davem@davemloft.net>
In-Reply-To: 9a7cd34e2d8688364297d700bfd8aea60c3a6c7f.1584653622.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4051

--===============2045539899469460565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Davide Caratti <dcaratti(a)redhat.com>
Date: Thu, 19 Mar 2020 22:45:37 +0100

> it's still possible for packetdrill to hang in mptcp_sendmsg(), when the
> MPTCP socket falls back to regular TCP (e.g. after receiving unsupported
> flags/version during the three-way handshake). Adjust MPTCP socket state
> earlier, to ensure correct functionality of mptcp_sendmsg() even in case
> of TCP fallback.
> =

> Fixes: 767d3ded5fb8 ("net: mptcp: don't hang before sending 'MP capable w=
ith data'")
> Fixes: 1954b86016cf ("mptcp: Check connection state before attempting sen=
d")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>

APplied.
--===============2045539899469460565==--
