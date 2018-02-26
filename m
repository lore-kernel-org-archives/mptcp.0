Content-Type: multipart/mixed; boundary="===============5544243686988863435=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Next steps discussion
Date: Mon, 26 Feb 2018 10:57:58 +0100
Message-ID: <20180226095758.GX1235@MacBook-Pro-4.local>
X-Status: 
X-Keywords:                  
X-UID: 315

--===============5544243686988863435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

as for next steps after the submission of the TCP-option framework to netdev
and DaveM's feedback on it.

Even if the submission got rejected, I think we still have a very useful set
of patches here. The need for a framework might pop up again in the future,
and so these patches could come in handy.
Mat, maybe you can put our latest submission on your kernel.org-git repo
just so that we don't lose track of these patches? I can also create a
github repo if you prefer that.


As for DaveM's feedback, the main takeaway - as Mat already noted on his ot=
her
mail - is that fast-path performance he the highest priority. Branching and
indirect function calls are hardly accepted there.


So, in that spirit I think we need to work towards reducing MPTCP's
intrusiveness to the TCP stack.

* Stop taking meta-lock when receiving subflow data (all the changes where
  we check for mptcp(tp) and then do bh_lock_sock(meta_sk)).
  The reason we do this in today's implementation is because it allows to
  access the meta data-structure at any point. If we stop taking the
  meta-lock a few things need to change:
  1. Do lockless accesses for selected fields (e.g., for the DATA_ACK).
  2. Group the more intrusive accesses to few select points in the TCP-stack
     where we then take the meta-lock (e.g., when receiving data).
     (this would be equivalent as if the TCP-option framework would be there
     - thus we need to move code to these or similar points in the stack)
  3. Sometimes schedule work-queues when we need to avoid deadlocks due to
     lock-ordering issues (e.g., when we can't take the meta-lock because
     it's already held by another thread).

  I think, the way to approach this here, is by working iteratively and sta=
rt
  moving code in such a way that accesses to the meta-socket are grouped
  together.

  Also, we have a few callbacks that we added (cfr., struct tcp_sock_ops).
  We added them to avoid duplicating the code. Let's review those and see if
  we can get rid of them. (as an example: .send_fin could be removed as it =
is only
  called from tcp_shutdown, called from the .shutdown callback in tcp_prot -
  thus if we expose a separate MPTCP socket-type with its own struct proto,
  we can get rid of the .send_fin callback)

* Investigate how/if we can make MPTCP adopt KCM or ULP.

* There is still the open question of the API, path-management,... Tessares
  has some experience with that, so maybe they can provide some ideas here.

* The size of the skb. Well, we have been discussing this for quite a while=
 :)
  One option is always to have a lookup table as they do for the
  TLS-records. That will hurt performance, but at least it's a step forward.
  And we have a bunch of other ideas that might be worth exploring as well.
  If I'm not mistaken, Rao had an approach that could work as well, right?


Any other comments, suggestions,...? :-)


On my side, as a first concrete step, I will work towards lockless subflow
establishment. In tcp_v4_rcv, we are currently taking the meta-level lock
when the socket-lookup matches on a request-socket. Now that TCP supports
lockless listeners, MPTCP should do that as well.


Cheers,
Christoph


--===============5544243686988863435==--
