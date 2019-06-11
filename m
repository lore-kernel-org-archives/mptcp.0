Content-Type: multipart/mixed; boundary="===============6858495259130475985=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: increase timeout and return
 error on ping failure
Date: Tue, 11 Jun 2019 10:43:56 +0200
Message-ID: <f85b06b729f23d11a96a88dccdae42036ad39153.camel@redhat.com>
In-Reply-To: 465721ff-f803-b900-6b29-5afe890f30af@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1327

--===============6858495259130475985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for lagging behind ...
On Tue, 2019-06-11 at 10:32 +0200, Matthieu Baerts wrote:
> Hi Florian, Paolo,
> =

> On 05/06/2019 11:36, Florian Westphal wrote:
> > Now that we add a qdisc that does random drop, there is a small chance
> > for the ping to be dropped, so this triggers:
> > ns2 -> 10.0.1.2 connectivity [ FAIL ]
> > =

> > To fix this, split the ping test part to its own loop and only
> > add the qdiscs after the ping tests have completed.
> > =

> > Also, the script would still exit with 0 status in this case, so update
> > run_tests to check the return value of do_transfer() rather than rely on
> > that function to set the global exit state in all cases.
> > =

> > Last, increase the timeout: with qdiscs present, 10 seconds is too low:
> > in some rare cases sender or receiver exited too early.
> =

> The patch looks good to me!
> =

> @Paolo: as a major contributor to this shell script, is this patch also
> looks good to you?

Just reviewed. Yes, the patch LGTM, too.

> Just one question for later: should we print something when we start
> adding delays, losses and reordering?

I *think* it's not required. We could print the traversed artifacts in
the test name/info line, but looks a bit overkill/overcomplicated.

Cheers,

Paolo


--===============6858495259130475985==--
