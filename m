Content-Type: multipart/mixed; boundary="===============5426569636193910105=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 0/6] mptcp_poll rework preview
Date: Mon, 16 Sep 2019 18:37:44 +0200
Message-ID: <90fe1f1df1eb0d88beaae8e9305ee3db27b53428.camel@redhat.com>
In-Reply-To: 20190909155317.31119-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1851

--===============5426569636193910105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2019-09-09 at 17:53 +0200, Florian Westphal wrote:
> This patch series is in need of a bit more work, f.e. there is too much
> copypastry in patch 3.
> =

> However, it is functional as-is so I am sharing it to get earlier reviews.
> =

> Problem with current mptcp_poll() is that we can't block the task on each
> subflow: subflow we're polling on might be idle while another one has data
> ready for processing.

If I read the series correctly, patch 3 is not strictly needed for the
above goal: AFAICS it should help to avoid empty/blocking recvmsg()
after successful poll(), right?

I think we should rework a bit recvmsg() before going on with this -
see "mptcp: partial recvmsg() refactor". Perhaps even something more
drastic e.g. subflow could try move skbs from ssk->sk_receive_queue to
a per msk queue, ordered by mptcp seq in subflow_data_ready(). WDYT?

Cheers,

Paolo


--===============5426569636193910105==--
