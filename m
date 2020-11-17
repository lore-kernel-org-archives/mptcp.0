Content-Type: multipart/mixed; boundary="===============8968999411059979926=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/6] mptcp: separate accouting for wmem forward
 alloc mem
Date: Tue, 17 Nov 2020 11:47:59 +0100
Message-ID: <20201117104759.GG22792@breakpoint.cc>
In-Reply-To: e023afa8f4ad8536aaaab41584917775beec41ca.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6761

--===============8968999411059979926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> As mentioned before, one possible follow-up to this series is open-code =

> a MPTCP-specific variant of lock_sock()/release_sock() which will allow
> performing some additional/MPTCP specific actions under the msk level
> spinlock.
> =

> Specifically:
> =

> - in recevmsg(), in lock_sock(), splice sk->sk_receive_queue in msk-
> >receive_queue
> - still in recvmsg(), in release_sock(), update the bulk freed rmem =

> =

> Overall this 2 will allow acquiring no additional spinlock at all in
> the average case for recvmsg()
> =

> - in sendmsg(), in lock_sock(), move as much memory as needed from
> sk_forward_memory to wforward_memory, eventually allocating it.
> - in sendmsg(), in release_sock(), move again the unused
> wforward_memory to sk_forward_memory.
> =

> Overall this 2 will allow acquiring no additional spinlock at all in
> the average case for sendmsg() and will avoid artifacts due to the
> sk_forward_memory/wforward_memory separation.
> =

> But they additionally will allow replacing the wforward_memory field
> with a local variable. =

> =

> So I'm wondering if I should already code the above, to avoid
> introducing this additional new msk field just to remove it in a few
> patches !?!

Tricky.  Do you have hunch of how much additional code churn that
means?

If its not too much 'rewrite', I would prefer to do it later on
even if that means axing the newly added field.

If it means to rewrite most of this again then its probably
better to do it right away.
--===============8968999411059979926==--
