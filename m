Content-Type: multipart/mixed; boundary="===============8971749426215370457=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: silence warning in
 subflow_data_ready()
Date: Thu, 16 Jul 2020 11:52:45 +0200
Message-ID: <3e97692a-4fa2-9b39-e31a-96deae6f5a57@tessares.net>
In-Reply-To: 87f4954cfd7eacd6e220ab60d61e09f35ed32252.1594844608.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5040

--===============8971749426215370457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 15/07/2020 22:27, Davide Caratti wrote:
> since commit d47a72152097 ("mptcp: fix race in subflow_data_ready()"), it
> is possible to observe a regression in MP_JOIN kselftests. For sockets in
> TCP_CLOSE state, it's not sufficient to just wake up the main socket: we
> also need to ensure that received data are made available to the reader.
> Silence the WARN_ON_ONCE() in these cases: it preserves the syzkaller fix
> and restores kselftests	when they are ran as follows:
> =

>    # while true; do
>    > make KBUILD_OUTPUT=3D/tmp/kselftest TARGETS=3Dnet/mptcp kselftest
>    > done
> =

> Reported-by: Florian Westphal <fw(a)strlen.de>
> Fixes: d47a72152097 ("mptcp: fix race in subflow_data_ready()")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/47
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>

Thank you for the patch!
It looks good to me and it fixes the kselftests on my side as well!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8971749426215370457==--
