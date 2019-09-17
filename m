Content-Type: multipart/mixed; boundary="===============3892372081293502453=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 0/6] mptcp_poll rework preview
Date: Tue, 17 Sep 2019 08:42:07 +0200
Message-ID: <20190917064207.GB6961@breakpoint.cc>
In-Reply-To: 90fe1f1df1eb0d88beaae8e9305ee3db27b53428.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1858

--===============3892372081293502453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-09-09 at 17:53 +0200, Florian Westphal wrote:
> > This patch series is in need of a bit more work, f.e. there is too much
> > copypastry in patch 3.
> > =

> > However, it is functional as-is so I am sharing it to get earlier revie=
ws.
> > =

> > Problem with current mptcp_poll() is that we can't block the task on ea=
ch
> > subflow: subflow we're polling on might be idle while another one has d=
ata
> > ready for processing.
> =

> If I read the series correctly, patch 3 is not strictly needed for the
> above goal: AFAICS it should help to avoid empty/blocking recvmsg()
> after successful poll(), right?

Thats right.  EPOLLIN means next recv won't block, which isn't the case
at this time because we do mptcp processing in recv only.

> I think we should rework a bit recvmsg() before going on with this -
> see "mptcp: partial recvmsg() refactor".

Agree.

> Perhaps even something more
> drastic e.g. subflow could try move skbs from ssk->sk_receive_queue to
> a per msk queue, ordered by mptcp seq in subflow_data_ready(). WDYT?

Yes, that might be a good idea/needed.
We shouldn't depend on regular recv calls for mptcp processing.

--===============3892372081293502453==--
