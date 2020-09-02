Content-Type: multipart/mixed; boundary="===============1382950392413839240=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] selftests: mptcp: fix typo in
 mptcp_connect usage
Date: Wed, 02 Sep 2020 15:32:30 +0200
Message-ID: <022366c7-c916-8841-348b-b1981341b810@tessares.net>
In-Reply-To: 6c43e5404c41f91ed9324e20c35a4e4fdb0ed1de.1599046871.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5696

--===============1382950392413839240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 02/09/2020 13:44, Davide Caratti wrote:
> in mptcp_connect, 's' selects IPPROTO_MPTCP / IPPROTO_TCP as the value of
> 'protocol' in socket(), and 'm' switches between different send / receive
> modes. Fix die_usage(): swap 'm' and 's' and add missing 'sendfile' mode.

Good catch!

I guess we don't need this on -net or further, this test program is =

always used with its wrapper mptcp_connect.sh.

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1382950392413839240==--
