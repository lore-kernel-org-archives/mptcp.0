Content-Type: multipart/mixed; boundary="===============6567122970962448741=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: fix race in subflow_data_ready()
Date: Mon, 06 Jul 2020 13:31:42 -0700
Message-ID: <20200706.133142.2053119289184509872.davem@davemloft.net>
In-Reply-To: 4eed4130aba55b8a2b3854fe99d254a50530866b.1594062200.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4930

--===============6567122970962448741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Davide Caratti <dcaratti(a)redhat.com>
Date: Mon,  6 Jul 2020 21:06:12 +0200

> syzkaller was able to make the kernel reach subflow_data_ready() for a
> server subflow that was closed before subflow_finish_connect() completed.
> In these cases we can avoid using the path for regular/fallback MPTCP
> data, and just wake the main socket, to avoid the following warning:
 ...
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/39
> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Fixes: e1ff9e82e2ea ("net: mptcp: improve fallback to TCP")
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>

Applied, thank you.
--===============6567122970962448741==--
