Content-Type: multipart/mixed; boundary="===============2014210179457335550=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: Remove set but not used variable
 'can_ack'
Date: Sat, 21 Mar 2020 20:21:03 -0700
Message-ID: <20200321.202103.682709364176957538.davem@davemloft.net>
In-Reply-To: 20200318020157.178956-1-yuehaibing@huawei.com
X-Status: 
X-Keywords:                  
X-UID: 4038

--===============2014210179457335550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: YueHaibing <yuehaibing(a)huawei.com>
Date: Wed, 18 Mar 2020 02:01:57 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> =

> net/mptcp/options.c: In function 'mptcp_established_options_dss':
> net/mptcp/options.c:338:7: warning:
>  variable 'can_ack' set but not used [-Wunused-but-set-variable]
> =

> commit dc093db5cc05 ("mptcp: drop unneeded checks")
> leave behind this unused, remove it.
> =

> Signed-off-by: YueHaibing <yuehaibing(a)huawei.com>

Applied, thanks.
--===============2014210179457335550==--
