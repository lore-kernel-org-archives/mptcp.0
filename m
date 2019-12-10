Content-Type: multipart/mixed; boundary="===============5595369955405698131=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Tue, 10 Dec 2019 19:24:33 +0100
Message-ID: <c5fff733-ae59-57cd-de57-3958cd49df9f@tessares.net>
In-Reply-To: 231a2fa522f7713fc8d8b0a5069153b2a40a1293.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2866

--===============5595369955405698131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 09/12/2019 13:33, Paolo Abeni wrote:
> Hi,
> =

> On Sun, 2019-12-08 at 19:24 +0100, Florian Westphal wrote:
>> It includes 48 patches (down from 66), I will refrain from patch-bombing
>> the list with it.  There is one patch as followup here because its
>> "almost new" in the sense that its an amalgamation of different patches
>> that I placed in that commit because the others seemed quite large alrea=
dy.
>>
>> The __tcp_poll patch is gone.  Later patches, in particular the changes =
to
>> only store 'tcp_sock' rather than 'struct socket' on the conn_list, have
>> been brought forward and squashed into the relevant commits, would thus
>> be implicitly part of basic mptcp submission.  I've amemded commit
>> messages where appropriate.
> =

> Thank you Florian for the great work!
> =

> I went through the patches up to v1 support, and LGTM.

It is also good to me! Thank you very much for the very big work! The =

kind of work where even you you have to sit down to do it! ...  O:-D

I just re-created the tree using your branch. I am also checking now =

that all commits are OK, with and without MPTCP. Also the usual =

compilation tests with i386 and without IPv6.

I will do a second pass on the different commits tomorrow!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5595369955405698131==--
