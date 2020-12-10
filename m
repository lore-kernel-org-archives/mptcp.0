Content-Type: multipart/mixed; boundary="===============2980736542363277455=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 00/11] mptcp: Add port parameter to
 ADD_ADDR option
Date: Wed, 09 Dec 2020 19:04:49 -0800
Message-ID: <20201209.190449.1520052078880395868.davem@davemloft.net>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7120

--===============2980736542363277455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Wed,  9 Dec 2020 15:51:17 -0800

> The ADD_ADDR MPTCP option is used to announce available IP addresses
> that a peer may connect to when adding more TCP subflows to an existing
> MPTCP connection. There is an optional port number field in that
> ADD_ADDR header, and this patch set adds capability for that port number
> to be sent and received.
> =

> Patches 1, 2, and 4 refactor existing ADD_ADDR code to simplify implement=
ation
> of port number support.
> =

> Patches 3 and 5 are the main functional changes, for sending and
> receiving the port number in the MPTCP ADD_ADDR option.
> =

> Patch 6 sends the ADD_ADDR option with port number on a bare TCP ACK,
> since the extra length of the option may run in to cases where
> sufficient TCP option space is not available on a data packet.
> =

> Patch 7 plumbs in port number support for the in-kernel MPTCP path
> manager.
> =

> Patches 8-11 add some optional debug output and a little more cleanup
> refactoring.

Series applied, thanks.
--===============2980736542363277455==--
