Content-Type: multipart/mixed; boundary="===============3462220267929617234=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 02/11] sock: Make sk_protocol a 16-bit
 value
Date: Fri, 20 Dec 2019 07:37:14 -0800
Message-ID: <8354e6ef-c4ec-080f-5272-baf825646c83@gmail.com>
In-Reply-To: 20191219223434.19722-3-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3221

--===============3462220267929617234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/19/19 2:34 PM, Mat Martineau wrote:
> Match the 16-bit width of skbuff->protocol. Fills an 8-bit hole so
> sizeof(struct sock) does not change.
> =

> v2 -> v3:
>  - keep 'sk_type' 2 bytes aligned (Eric)
> v1 -> v2:
>  - preserve sk_pacing_shift as bit field (Eric)
> =

> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---


Reviewed-by: Eric Dumazet <edumazet(a)google.com>

--===============3462220267929617234==--
