Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8968
	for <mptcp@lists.linux.dev>; Sat, 20 Nov 2021 17:47:46 +0000 (UTC)
Received: from smtpclient.apple ([86.159.109.142]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1MW9zm-1n8rog3zEw-00XbJh; Sat, 20 Nov 2021 18:47:29 +0100
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Subflow Creation / Management Issues
From: Phil Greenland <phil@quantulum.co.uk>
In-Reply-To: <e34629ee-034-1544-163b-368d3ad9641@linux.intel.com>
Date: Sat, 20 Nov 2021 17:47:27 +0000
Cc: mptcp@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <431BA531-B8F7-4617-B416-CBFB2B9380A9@quantulum.co.uk>
References: <EF21766C-4DF4-4F06-8076-16391C7D56D5@quantulum.co.uk>
 <e34629ee-034-1544-163b-368d3ad9641@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 pabeni@redhat.com
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Provags-ID: V03:K1:8sOshjYgmefsBLk9gOnwV3RZgVMWFJwUiai+2n4rNo4Pntbhvy3
 r0oEY699uejR/qFFgcxDaLSk0ZQZ5lpGQB0qP+3q/BbczRtXwegBqh1wejoba+MTW8Qltrc
 TjvmjRgqz17EV2Y/Kyf8+Szuos+PkXeYVF5UoY9H9tnZ6/raGt7nsWkhXgnC6RLVi/eV6YP
 7ECYKIQmguD2RrYDj9WHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u/YCebLka6g=:7iEj8D9xPMLmgw76RroGcx
 1OSwEMw2MBJK91xBrSdrPMq0YoednQSx0erHMLiSkzwMscPOAJ1EuYyDi7jnY38kxB5rRVOaO
 WXJM2kfQyjzAVvnco5UTkybY5TlphyhdngoXW+jJz1EPso3JtRRkNUxTm1eSbmnXrwPrn3/Ce
 ymc9eMPVoRRQBpCrVOWm/OgFp3Q5bjCCDHSE/jz0DFfHdB2IgAlOkt/8F7xWZlAlFMOjD5brX
 PqpL5cekOfoBKun3FQedfKJZDEsAI5uJTjny0MHjmpBck5jATUw40xM/aIYTR6H6qEjnZII1f
 yqt6ZSOW2q7hElS6sJk90RTIDHAUfqfGZfGXdMBKLpOFo46+72r5st/jkbxpxjA7M/6ufKxf8
 yL6PXDCRfDu6ywtIIalunJvgZkCfth7bPcs2k/8GQi3hswicuAXkTkq5kLaK6UZpiTB+1u2Mi
 f9Y1okQ/QZ6thcpVn2wlH4rAGk8VawPsKrN++YJMzYPYWbYFIyXZChmbdsnWRbQprYCGJAiqJ
 D8KqLcjrW8PR2AFzOHuLeALTafwbSSrrpk2fcI4eS+0FycxF8QanGNIY1QYaaEj3HSOCkwhnW
 JZn13r4YJ4TX5uBeTSqttuuohLcztFyd5/uSpgME6U+MEzYUQexTnD9qg74G5dRD2vPrA8DL8
 kuqC4R9ae7rv8PT/UhcHMiNdQ8ERh8Go5cwmCe1mjPOWKEzjMfeBvProB+yUE4L4t6R0=

Hi Mat and Paolo,

I=E2=80=99ve raised an issue for scenario 1+3 =
(https://github.com/multipath-tcp/mptcp_net-next/issues/242) with a =
packet capture and hopefully detailed enough notes to reproduce. I=E2=80=99=
ve not mentioned scenario 3 specifically but from my nosing at the code =
it appears to be a follow on from the behaviour described.

I=E2=80=99ve added a comment to the other ticket on the subflow =
management front.

Userspace path management wise, I built the daemon a while ago, before =
spotting that it was the out-of-tree kernel that had support for subflow =
management and it was still in the pipeline for in-tree implementation =
(think I=E2=80=99m right there?).

When it comes along it would certainly be one way of achieving our =
re-connection goals.

As mentioned in my GitHub comment our use case is pretty simple. =
Creating a limited number of connections from the client, over =
unreliable links, with subflows up and connected whenever possible. If =
the kernel could support a basic reconnection strategy this would be our =
preferred option initially.

Down the line we were looking to setup something slightly more =
elaborate.

At present we=E2=80=99ve got a low bandwidth stream of critical control =
data, which should be allowed to travel over any and all available =
interfaces, although prefer our faster / lower cost ones when possible =
(we=E2=80=99re hoping to use the subflow backup option for this=E2=80=A6.n=
ot quite got there yet though).

We=E2=80=99d like to add a high bandwidth stream of additional =
telemetry, which should only be allowed to create subflows over specific =
interfaces (our fast, low cost ones, avoiding a slow and comparatively =
expensive link).

This scenario would likely benefit from user space path management.

It seems that this would be completely achievable via a custom mptcpd =
plugin expressing our rules, once the in-tree kernel supports userspace =
subflow management.

A generic configuration file driven, rules based plugin would be the =
dream, to save me writing my own=E2=80=A6although I=E2=80=99m not sure =
what the rules would look like, so possibly a bit of a stretch :-P.

Thanks for the advice and super fast replies!

Regards,

Phil

> On 17 Nov 2021, at 01:22, Mat Martineau =
<mathew.j.martineau@linux.intel.com> wrote:
>=20
>=20
> Hello Phil,
>=20
> On Mon, 15 Nov 2021, Phil Greenland wrote:
>=20
>> Hi,
>>=20
>> I=E2=80=99m currently working with a client, integrating MPTCP into =
their platform, with a goal of achieving reliable connectivity over a =
mix of WAN technologies.
>>=20
>> We started using 5.14 but were having problems getting MPTCP to =
handover between subflows when connectivity on individual links became =
poor.
>>=20
>> Updating to 5.15 brought a massive improvement. With the scheduler =
updates (stale subflow detection) handovers between links are now =
virtually seamless. Great work :-)
>>=20
>> We=E2=80=99ve started looking at corner cases that we might =
experience in the field.
>>=20
>> In our use case all connections originate from the client, to a =
server on the internet. The client has multiple endpoint addresses =
registered via =E2=80=9Cip mptcp=E2=80=9D, over which multiple subflows =
are created.
>>=20
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94
>>=20
>> Scenario 1)
>>=20
>> If we take network links up and down, adding and removing endpoint =
addresses as we do so, everything appears to work well, subflows are =
connected and disconnected as expected.
>>=20
>> However if a subflow fails, for example due to reception of a TCP RST =
from a NAT this seems to cause problems.
>>=20
>> The next time a link is taken down (a link other than the failing =
one), the associated subflow is disconnected as expected.
>>=20
>> When the link is brought back up, more often than not the failed =
subflow (the one stopped by a TCP RST) it re-connected and the newly =
added endpoint address, associated with the interface that was just =
brought up is not used.
>>=20
>> I believe this behaviour is due to an interaction between the =
local_addr_used variable within the MPTCP meta socket pm structure and =
the logic in select_local_address.
>>=20
>> The variable is incremented and decremented on subflow connection / =
disconnection (following endpoint addition / removal), but it's not =
decremented following the failure of a subflow.
>>=20
>> The select_local_address function only seems to check if a local =
address is currently in use before returning it.
>>=20
>> Therefore when an address is removed / re-added a single new subflow =
is permitted to be created (due to local_addr_used < local_addr_max), =
however the select_local_address function returns the first available =
address.
>>=20
>> Scenario 2)
>>=20
>> Following the initial MPTCP flow creation (with id 0?), if a subflow =
connection fails to be established, due to a connect timeout for =
example, no further subflows are established for the connection.
>>=20
>> It appears that the subflow connection success handler =
mptcp_pm_nl_subflow_established triggers the establishment of the next. =
Such that once the chain is broken by a failed connection no further =
subflows are established, even if unused endpoint addresses remain.
>>=20
>> Scenario 3)
>>=20
>> As a continuation of scenario 1, if for some strange reason all =
subflows were to fail, all at once, or over time. I'm left with just the =
MPTCP meta socket. The application believes it's still connected but =
there=E2=80=99s no way it seems to recover the connection. Other than =
adding a new endpoint address, which will trigger one of the subflows =
(again not necessarily the new endpoint) to be re-connected.
>>=20
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94
>>=20
>=20
> First, thank you for the feedback - it's very helpful to know how this =
MPTCP implementation is getting used and what issues people are running =
in to.
>=20
> Paolo covered your questions well in relation to the existing =
in-kernel path manager that's responsible for controlling subflow =
establishment. (Thanks Paolo!)
>=20
>> Is there anything on your roadmap that might help address these few =
issues above?
>>=20
>=20
> I think we may have something in development that will fit your needs =
better on the client side: userspace path management.
>=20
> The existing in-kernel path manager is best suited to server-side use =
cases. We can still improve it to better handle the issues you've =
observed, and Paolo's advice on github issues =
(https://github.com/multipath-tcp/mptcp_net-next/issues) will help with =
that.
>=20
> Userspace path management will add more netlink calls that allow a =
userspace program like mptcpd (https://github.com/intel/mptcpd) to =
control the establishement of subflows - and to customize path =
management without requiring changes to the kernel. The tradeoff is the =
overhead of using the netlink API, so this is better suited to client =
devices with a smaller number of connections, as opposed to a server =
with hundreds or thousands of connections.
>=20
> Does that sound like a fit for what you're doing on the client side?
>=20
>> I=E2=80=99ve been considering a temporary hack, which I hope would =
address all three. Adding a netlink call, based heavily on your add =
address handler, to walk the meta socket list, and try to reconnect any =
/ all failed subflows. Which I can call periodically or in response to =
network events.
>>=20
>> I=E2=80=99d happily attempt to develop a more formal fix, with some =
guidance, but haven=E2=80=99t done lot of Linux kernel development in =
the past.
>>=20
>> Apologies for the long email / keep up the great work! It=E2=80=99s =
really good to see MPTCP make it into the mainline kernel.
>>=20
>=20
> Thanks again for the long email and the encouragement!
>=20
>=20
> --
> Mat Martineau
> Intel

