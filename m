Content-Type: multipart/mixed; boundary="===============9117290935991345881=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/6] mptcp: update mptcp ack sequence from work
 queue
Date: Wed, 19 Feb 2020 13:36:08 +0100
Message-ID: <cdfd6084ad257bfd74de8c4ae36aab914504e3a0.camel@redhat.com>
In-Reply-To: 20200218122110.23817-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3700

--===============9117290935991345881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-18 at 13:21 +0100, Florian Westphal wrote:
> This is v3 of the attempt to allow mptcp to update its ack-sequence
> number even if userspace doesn't call recv() for some time.
> This includes a change to patch 2/6 to address a theoretical race when
> two subflows deliver same data: previous version may have discarded the
> additional data correctly, but would leave EPOLLIN indication enabled,
> even though all data has to be tossed as duplicate.
> =

> Rest of patches is unchanged.

The series LGTM.

My understanding is that the patches are not going to be squashed, just
sent directly U/S, right?

If so I think the commit message in patch 2 and 3 should be cleaned-up
a bit.

Thanks,

Paolo

--===============9117290935991345881==--
