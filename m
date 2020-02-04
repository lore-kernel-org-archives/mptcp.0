Content-Type: multipart/mixed; boundary="===============2475059826959171378=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: use-after-free Write in __lock_sock
Date: Tue, 04 Feb 2020 11:46:17 +0100
Message-ID: <20200204104617.GF15904@breakpoint.cc>
In-Reply-To: 5b235b4f2636c7621be6a8526e8b6f5cfb7852de.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3581

--===============2475059826959171378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Tue, 2020-02-04 at 00:59 +0100, Florian Westphal wrote:
> > AFAICS we need to revert to a state we had very early on:
> > proxy tcp fallback case everywhere: msk is left alone and
> > sendmsg/recvmsg and so on invoke the tcp versions on the (only) ssk.
> =

> That is unfortunated, I liked the fact that a fallback socket got the
> same performances of a plain TCP socket (could encourage MPTCP adoption
> - not sure that is good thing, anyway ;)

Heh.

> On the plus side, __mptcp_tcp_fallback() should be already hooked in
> every place where we need special/single subflow handling. Should be
> just a matter of simplify __mptcp_tcp_fallback() to just return the
> subflow sk.

Yes, I can confirm that I don't get a crash when i dumb-down the
fallback to always proxy.

> I guess/hope we can still call mptcp_subflow_tcp_fallback() - so that
> at least we get no overhead in the BH processing for the fall-back sk.

Right, I will have a look to see if we can repair it somehow.

If we have to go with always-proxy we will still have the server-side
mostly covered hwoever, mptcp accept will still return plain tcp sk for
non-mptcp syn case.
--===============2475059826959171378==--
