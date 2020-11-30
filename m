Content-Type: multipart/mixed; boundary="===============1946215609898526843=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/3] mptcp: reject invalid mp_join requests
 right away
Date: Mon, 30 Nov 2020 16:36:28 +0100
Message-ID: <20201130153631.21872-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6988

--===============1946215609898526843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At the moment MPTCP can detect an invalid join request (invalid token,
max number of subflows reached, and so on) right away but cannot reject
the connection until the 3WHS has completed.
Instead the connection will complete and the subflow is reset afterwards.

To send the reset most information is already available, but we don't have
good spot where the reset could be sent:

1. The ->init_req callback is too early and also doesn't allow to return an
   error that could be used to inform the TCP stack that the SYN should be
   dropped.

2. The ->route_req callback lacks the skb needed to send a reset.

3. The ->send_synack callback is the best fit from the available hooks,
   but its called after the request socket has been inserted into the queue
   already. This means we'd have to remove it again right away.

From a technical point of view, the second hook would be best:
 1. Its before insertion into listener queue.
 2. If it returns NULL TCP will drop the packet for us.

Problem is that we'd have to pass the skb to the function just for MPTCP.

Paolo suggested to merge init_req and route_req callbacks instead:
This makes all info available to MPTCP -- a return value of NULL drops the
packet and MPTCP can send the reset if needed.

Because 'route_req' has a 'const struct sock *', this means either removal
of const qualifier, or a bit of code churn to pass 'const' in security land.

This does the latter; I did not find any spots that need write access to st=
ruct
sock.

To recap, the two alternatives are:
1. Solve it entirely in MPTCP: use the ->send_synack callback to
   unlink the request socket from the listener & drop it.
2. Avoid 'security' churn by removing the const qualifier.


--===============1946215609898526843==--
