Content-Type: multipart/mixed; boundary="===============2453189503220834965=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 01/11] net: Make sock protocol value
 checks more specific
Date: Fri, 20 Dec 2019 07:35:27 -0800
Message-ID: <ce72abad-ef13-ffee-8dca-0efddd1ccb2c@gmail.com>
In-Reply-To: 20191219223434.19722-2-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3220

--===============2453189503220834965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/19/19 2:34 PM, Mat Martineau wrote:
> SK_PROTOCOL_MAX is only used in two places, for DECNet and AX.25. The
> limits have more to do with the those protocol definitions than they do
> with the data type of sk_protocol, so remove SK_PROTOCOL_MAX and use
> U8_MAX directly.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Reviewed-by: Eric Dumazet <edumazet(a)google.com>
--===============2453189503220834965==--
