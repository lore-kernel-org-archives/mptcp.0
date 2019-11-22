Content-Type: multipart/mixed; boundary="===============0987232390683365000=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] crypto: refactor sha code
Date: Fri, 22 Nov 2019 17:26:18 +0100
Message-ID: <1786d802-8211-d99f-eca3-fb82877a192f@tessares.net>
In-Reply-To: 34a3db383cb02ac6a81a1edb2afde5f432f18651.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2666

--===============0987232390683365000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 22/11/2019 15:30, Paolo Abeni wrote:
> On Fri, 2019-11-22 at 15:26 +0100, Paolo Abeni wrote:
>> patch 1/4 refactor the crypto code to make it easier transitioning to
>> sha256. It includes feedback from Peter about helper renaming.

Thank you for this new version!

It looks good to me after a very very quick review (but the first patch =

is hard to read).

>> The following patches update the rest of the tree to the new helper name.
>> Overall this should generate 3 conflicts along the rebase.
> =

> Addendum:
> =

> The squashed tree is avaialble here:
> =

> https://github.com/pabeni/mptcp/tree/sha_cleanup_2
> =

> I verified the new code ensuring that the genrated seq number matched
> the expectation of the wireshark dissector.

Great!

Because it looks OK and you checked different stuffs, do you want me to:
- replace the tree with the commits from your branch? (if needed, we can =

of course do other fixes later)
- stop the CI job, wait for a proper review and then replace the tree?
- or wait for a proper review and then I apply the changes, looking at =

your branch in case of conflict but doing all of that with TopGit to =

ease the review? :)

Cheers,
Matt

> Cheers,
> =

> Paolo
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0987232390683365000==--
