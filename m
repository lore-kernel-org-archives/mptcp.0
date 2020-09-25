Content-Type: multipart/mixed; boundary="===============8302177221101890773=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 00/16] mptcp: RM_ADDR/ADD_ADDR
 enhancements
Date: Thu, 24 Sep 2020 19:58:48 -0700
Message-ID: <20200924.195848.729334260699047552.davem@davemloft.net>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6042

--===============8302177221101890773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>
Date: Thu, 24 Sep 2020 08:29:46 +0800

> This series include two enhancements for the MPTCP path management,
> namely RM_ADDR support and ADD_ADDR echo support, as specified by RFC
> sections 3.4.1 and 3.4.2.
> =

> 1 RM_ADDR support include 9 patches (1-3 and 8-13):
> =

> Patch 1 is the helper for patch 2, these two patches add the RM_ADDR
> outgoing functions, which are derived from ADD_ADDR's corresponding
> functions.
> =

> Patch 3 adds the RM_ADDR incoming logic, when RM_ADDR suboption is
> received, close the subflow matching the rm_id, and update PM counter.
> =

> Patch 8 is the main remove routine. When the PM netlink removes an addres=
s,
> we traverse all the existing msk sockets to find the relevant sockets. Th=
en
> trigger the RM_ADDR signal and remove the subflow which using this local
> address, this subflow removing functions has been implemented in patch 9.
> =

> Finally, patches 10-13 are the self-tests for RM_ADDR.
> =

> 2 ADD_ADDR echo support include 7 patches (4-7 and 14-16).
> =

> Patch 4 adds the ADD_ADDR echo logic, when the ADD_ADDR suboption has been
> received, send out the same ADD_ADDR suboption with echo-flag, and no HMAC
> included.
> =

> Patches 5 and 6 are the self-tests for ADD_ADDR echo. Patch 7 is a little
> cleaning up.
> =

> Patch 14 and 15 are the helpers for patch 16. These three patches add
> the ADD_ADDR retransmition when no ADD_ADDR echo is received.

Series applied, thank you.
--===============8302177221101890773==--
