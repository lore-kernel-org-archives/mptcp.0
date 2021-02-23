Content-Type: multipart/mixed; boundary="===============1464158517932477263=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: reset 'first' and ack_hint on subflow
 close
Date: Tue, 23 Feb 2021 10:24:09 +0100
Message-ID: <47ed53d2-fe50-73ef-043a-a6c6161a8b88@tessares.net>
In-Reply-To: 20210222161815.27469-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7919

--===============1464158517932477263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 22/02/2021 17:18, Florian Westphal wrote:
> Just like with last_snd, we have to NULL 'first' on subflow close.
> =

> ack_hint isn't strictly required (its never dereferenced), but better to
> clear this explicitly as well instead of making it an exception.
> =

> msk->first is dereferenced unconditionally at accept time, but
> at that point the ssk is not on the conn_list yet -- this means
> worker can't see it when iterating the conn_list.
> =

> Reported-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Thank you for this patch!

Just applied in our tree, after "mptcp: dispose initial struct socket =

when its subflow is closed" with my RvB tag.

- 15d29d726a6e: mptcp: reset 'first' and ack_hint on subflow close
- Results: b5622a37311b..45795e8f868e

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1464158517932477263==--
