Content-Type: multipart/mixed; boundary="===============2008511350929351227=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 9/9] don't flag parent socket as RCV_SHUTDOWN
 if one one subflow has closed
Date: Tue, 03 Dec 2019 10:05:57 +0100
Message-ID: <096263668b065156c0b198a8e05790ab6b00530e.camel@redhat.com>
In-Reply-To: 9684c074-f270-cafc-79c4-232cc94bd4f0@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2759

--===============2008511350929351227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-03 at 08:44 +0100, Matthieu Baerts wrote:
> Hi Florian, Paolo, Mat,
> =

> On 02/12/2019 22:21, Paolo Abeni wrote:
> > On Mon, 2019-12-02 at 20:10 +0100, Florian Westphal wrote:
> =

> [...]
> =

> > Thanks for addressing my comments.
> > =

> > With 9/9 v2 the series is IMHO ready to me merged.
> =

> Thank you for the nice patch series and the reviews!
> Related to what we discussed yesterday, is it OK if I merge this after:
> =

>   1) DATA_FIN
>   2) MPTCPv1 =E2=86=92 wait a bit for a review
>   3) SendMsg "refactor" =E2=86=92 if reviewed
> =

> Or can I do that after the patches for MPTCPv1 if the patches to fix =

> sendmsg() have not been reviewed yet?

I think/hope this and sendmsg patches should not conflict much - but
sendmsg patches do create quite of conflict with the following patches.

I think that appling this series after v1 could be a good option, will
give extra time to review the sendmsg() patches, and I can rebase my
tree to help the merging.

Thanks,

Paolo

--===============2008511350929351227==--
