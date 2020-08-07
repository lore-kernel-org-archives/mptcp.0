Content-Type: multipart/mixed; boundary="===============9167482398834580685=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] selftests/mptcp: Better delay &
 reordering configuration
Date: Fri, 07 Aug 2020 19:51:40 +0200
Message-ID: <72b4b487-563f-a7ba-18b7-1c532df4f92c@tessares.net>
In-Reply-To: 20200807174741.70458-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 5518

--===============9167482398834580685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 07/08/2020 19:47, Christoph Paasch wrote:
> The delay was intended to be configured to "simulate" a high(er) BDP
> link. As such, it needs to be set as part of the loss-configuration and
> not as part of the netem reordering configuration.
> =

> The reordering-config also requires a delay but that delay is the
> reordering-extend. So, a good approach is to set the reordering-extend
> as a function of the configured latency. E.g., 25% of the overall
> latency.
> =

> To speed up the selftests, we limit the delay to 50ms maximum to avoid
> having the selftests run for too long.
> =

> Finally, the intention of tc_reorder was that when it is unset, the test
> picks a random configuration. However, currently it is always initialized
> and thus the random config won't be picked up.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/6
> =

> Reported-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> =

> Notes:
>      v2: Use "Closes" tag, properly use $(( ... )), limit delay to 50ms (=
feedback from Matthieu B.)

Thank you for this v2, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

I can apply it in the export branch and let the CI validating this!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============9167482398834580685==--
