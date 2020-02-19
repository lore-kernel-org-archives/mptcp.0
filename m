Content-Type: multipart/mixed; boundary="===============7808951622413913384=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/6] mptcp: update mptcp ack sequence from work
 queue
Date: Wed, 19 Feb 2020 13:43:18 +0100
Message-ID: <20200219124318.GL19559@breakpoint.cc>
In-Reply-To: cdfd6084ad257bfd74de8c4ae36aab914504e3a0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3701

--===============7808951622413913384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Tue, 2020-02-18 at 13:21 +0100, Florian Westphal wrote:
> > This is v3 of the attempt to allow mptcp to update its ack-sequence
> > number even if userspace doesn't call recv() for some time.
> > This includes a change to patch 2/6 to address a theoretical race when
> > two subflows deliver same data: previous version may have discarded the
> > additional data correctly, but would leave EPOLLIN indication enabled,
> > even though all data has to be tossed as duplicate.
> > =

> > Rest of patches is unchanged.
> =

> The series LGTM.
> =

> My understanding is that the patches are not going to be squashed, just
> sent directly U/S, right?

I don't mind, whatever seems more appropriate when we roll this
out to netdev.

3 and 6 could be squashed into #2.

But for now I think they can be applied as-is.

> If so I think the commit message in patch 2 and 3 should be cleaned-up
> a bit.

3 is too brief, yes, but whats missing in #2?
--===============7808951622413913384==--
