Content-Type: multipart/mixed; boundary="===============6696291213532812012=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Userspace Path Manager Draft
Date: Fri, 23 Mar 2018 16:14:43 +0000
Message-ID: <20180323161443.GA54772@MacBook-Pro-6.local>
In-Reply-To: 20180322204109.GA29903@pride
X-Status: 
X-Keywords:                  
X-UID: 405

--===============6696291213532812012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On 22/03/18 - 13:41:09, Stephen Brennan wrote:
> Hello everyone,
> =

> I did not sit in on the meeting since I am feeling sick, so I haven't had=
 a
> chance to see whether this is actually a useful contribution. However, ov=
er
> the past week I've been tinkering with the userspace Generic Netlink
> libraries, getting a prototype of what a userspace path manager framework
> could look like.

Awesome!

> My current idea is built so that it could support multiple path managers,
> implemented as shared libraries, which are dynamically loaded at runtime.
> There would need to be some policy or logic to decide which connections a=
re
> assigned to which path manager; I haven't fleshed out what that looks lik=
e.

I see, kinda like a pluggable path-manager in user-space, right?
I like that idea.

> Without an exact API reference, I simply based the API on what Ossama
> proposed last week. To test, I created a dummy kernel path manager which
> sends empty Netlink messages. It seems to work so far.
> =

> I don't know if those working on the Netlink API have been developing
> userspace tooling in parallel, but if not, maybe this will be useful.

I think it will be very useful. I'm sure that Matthieu has also a
path-manager daemon. But having an additional one with other use-cases and
implementations in mind will allow to validate that the netlink API works
for more diverse use-cases.

> You
> can find it here:
> =

> https://github.com/brenns10/pathmand

I will take a look at it.


Cheers,
Christoph


--===============6696291213532812012==--
