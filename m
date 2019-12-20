Content-Type: multipart/mixed; boundary="===============8258489188188033111=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 03/11] tcp: Define IPPROTO_MPTCP
Date: Fri, 20 Dec 2019 07:39:34 -0800
Message-ID: <69535a97-c505-235d-923c-266e7b3806b3@gmail.com>
In-Reply-To: 20191219223434.19722-4-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3222

--===============8258489188188033111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/19/19 2:34 PM, Mat Martineau wrote:
> To open a MPTCP socket with socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP),
> IPPROTO_MPTCP needs a value that differs from IPPROTO_TCP. The existing
> IPPROTO numbers mostly map directly to IANA-specified protocol numbers.
> MPTCP does not have a protocol number allocated because MPTCP packets
> use the TCP protocol number. Use private number not used OTA.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Reviewed-by: Eric Dumazet <edumazet(a)google.com>


--===============8258489188188033111==--
