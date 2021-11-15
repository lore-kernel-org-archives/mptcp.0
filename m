Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060DD2C80
	for <mptcp@lists.linux.dev>; Mon, 15 Nov 2021 22:44:35 +0000 (UTC)
Received: from smtpclient.apple ([86.159.109.142]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1MWSJJ-1nAb623tVr-00Xu2Y for <mptcp@lists.linux.dev>; Mon, 15 Nov 2021
 23:44:33 +0100
From: Phil Greenland <phil@quantulum.co.uk>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Subflow Creation / Management Issues
Message-Id: <EF21766C-4DF4-4F06-8076-16391C7D56D5@quantulum.co.uk>
Date: Mon, 15 Nov 2021 22:44:33 +0000
To: mptcp@lists.linux.dev
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Provags-ID: V03:K1:zFuqdozjedTKC8cgTC2IchsX6/WRwvaw6OUZMNy9w0nUKNQBoYM
 HRfzNxj/somHfELOLHpMYy+TdoLFnk+kidG5NO/xN3QsBm6q1/yp37xSmd2w4Y2yRDmM7lM
 JICygcsH0+xyDvgYRLDS0c5PNxLaIckIkddtRfjrFC6+l2IecZ6Fo9EYjGODYWeey6mkwMp
 0+3IO5e5YlIN+QXmpTplg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FgTNDOU5GIU=:Iul+tIo14AHpsXDCbmY1/D
 aS1W8kfuuGEBTmEylF1aQ0i31ZkIauW+s8RDPtxbUL27EKuKGeJnXOBlyJnryUyouz2csmsqc
 c7/OphOQBTSwBp8p/S0z0WcGbTmi7tkn1T1ww3907pYnzuyrJRXScO+zn0MjlVCB0lZP+jB18
 kITy9fXDVS7sbWom96kV9C4CZPuOOYYqCwzkPeA8cTwzKSQc2GgJ+fzEi0Vh89SUEJ7ZbAZLK
 +XwzksbehLM5u4yVNMMbKku5yOZYLqEJq5aJDf/6hbeqivl5UvuVle6dOv5LlFRMYs8h1lFit
 imDNxkdeQUaqdWL0/1UdXbFdDt8e8vAOloPhHOmAKSec4ELOCqPocyjUHGIXLuYvC5dUN2O2I
 Ac5HVCWom6IECJUPV/pZQG+algPXWOuDlV22EeuzTWp6QfnC+Amk5kBlnqFCFhtDvxtPbwhO4
 IR4aLc9HEYVZ5hy6VHcoqu0yMCRV2WPk1V1XzbOXTrIijyKXskFAgLGwB+QL/uWcaS1aUAowE
 KCSSmhl/FTVvaX/Yu5jkitUu8I27LBYHCDrsCGg/0PrICAWQ80V8LDzGV+01qcyiR+KL7aHRP
 FFUSPaj7QT0muKq7dApd0c0eRDJkfBzx3N2fivb3QkiSXexRtV6o3STIoHbdmJ4bv3fZ6z4Ci
 rDgLOgD2EMV03wALTGVGj4dg6nfRTDROOyJ/RA9zVHKs9zuk1dt4CLcYZsrlD02y6FpA=

Hi,

I=E2=80=99m currently working with a client, integrating MPTCP into =
their platform, with a goal of achieving reliable connectivity over a =
mix of WAN technologies.

We started using 5.14 but were having problems getting MPTCP to handover =
between subflows when connectivity on individual links became poor.

Updating to 5.15 brought a massive improvement. With the scheduler =
updates (stale subflow detection) handovers between links are now =
virtually seamless. Great work :-)

We=E2=80=99ve started looking at corner cases that we might experience =
in the field.

In our use case all connections originate from the client, to a server =
on the internet. The client has multiple endpoint addresses registered =
via =E2=80=9Cip mptcp=E2=80=9D, over which multiple subflows are =
created.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94

Scenario 1)

If we take network links up and down, adding and removing endpoint =
addresses as we do so, everything appears to work well, subflows are =
connected and disconnected as expected.

However if a subflow fails, for example due to reception of a TCP RST =
from a NAT this seems to cause problems.

The next time a link is taken down (a link other than the failing one), =
the associated subflow is disconnected as expected.

When the link is brought back up, more often than not the failed subflow =
(the one stopped by a TCP RST) it re-connected and the newly added =
endpoint address, associated with the interface that was just brought up =
is not used.

I believe this behaviour is due to an interaction between the =
local_addr_used variable within the MPTCP meta socket pm structure and =
the logic in select_local_address.

The variable is incremented and decremented on subflow connection / =
disconnection (following endpoint addition / removal), but it's not =
decremented following the failure of a subflow.

The select_local_address function only seems to check if a local address =
is currently in use before returning it.

Therefore when an address is removed / re-added a single new subflow is =
permitted to be created (due to local_addr_used < local_addr_max), =
however the select_local_address function returns the first available =
address.

Scenario 2)

Following the initial MPTCP flow creation (with id 0?), if a subflow =
connection fails to be established, due to a connect timeout for =
example, no further subflows are established for the connection.

It appears that the subflow connection success handler =
mptcp_pm_nl_subflow_established triggers the establishment of the next. =
Such that once the chain is broken by a failed connection no further =
subflows are established, even if unused endpoint addresses remain.

Scenario 3)

As a continuation of scenario 1, if for some strange reason all subflows =
were to fail, all at once, or over time. I'm left with just the MPTCP =
meta socket. The application believes it's still connected but there=E2=80=
=99s no way it seems to recover the connection. Other than adding a new =
endpoint address, which will trigger one of the subflows (again not =
necessarily the new endpoint) to be re-connected.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94

Is there anything on your roadmap that might help address these few =
issues above?

I=E2=80=99ve been considering a temporary hack, which I hope would =
address all three. Adding a netlink call, based heavily on your add =
address handler, to walk the meta socket list, and try to reconnect any =
/ all failed subflows. Which I can call periodically or in response to =
network events.

I=E2=80=99d happily attempt to develop a more formal fix, with some =
guidance, but haven=E2=80=99t done lot of Linux kernel development in =
the past.

Apologies for the long email / keep up the great work! It=E2=80=99s =
really good to see MPTCP make it into the mainline kernel.

Thanks,

Phil

Phil Greenland | Software Engineer | Quantulum Ltd

E  phil@quantulum.co.uk
W www.quantulum.co.uk

