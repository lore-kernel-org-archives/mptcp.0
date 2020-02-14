Content-Type: multipart/mixed; boundary="===============5378996217187316326=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2 2/3] mptcp: Protect subflow socket options
 before connection completes
Date: Fri, 14 Feb 2020 11:52:42 -0800
Message-ID: <alpine.OSX.2.22.394.2002141109260.55209@echiprou-mobl.amr.corp.intel.com>
In-Reply-To: cc7ba4b26f11019c6c110f5f0427fce90de725cd.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3660

--===============5378996217187316326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 14 Feb 2020, Paolo Abeni wrote:

> On Thu, 2020-02-13 at 12:38 -0800, Mat Martineau wrote:
>> Userspace should not be able to directly manipulate subflow socket
>> options before a connection is established since it is not yet known if
>> it will be an MPTCP subflow or a TCP fallback subflow. TCP fallback
>> subflows can be more directly controlled by userspace because they are
>> regular TCP connections, while MPTCP subflow sockets need to be
>> configured for the specific needs of MPTCP. Use the same logic as
>> sendmsg/recvmsg to ensure that socket option calls are only passed
>> through to known TCP fallback subflows.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  net/mptcp/protocol.c | 50 ++++++++++++++++++++++++--------------------
>>  1 file changed, 27 insertions(+), 23 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index a8faf66c38d8..0169e7dfc2d1 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -756,60 +756,64 @@ static int mptcp_setsockopt(struct sock *sk, int l=
evel, int optname,
>>  			    char __user *optval, unsigned int optlen)
>>  {
>>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> -	int ret =3D -EOPNOTSUPP;
>>  	struct socket *ssock;
>> -	struct sock *ssk;
>>
>>  	pr_debug("msk=3D%p", msk);
>>
>>  	/* @@ the meaning of setsockopt() when the socket is connected and
>> -	 * there are multiple subflows is not defined.
>> +	 * there are multiple subflows is not yet defined. It is up to the
>> +	 * MPTCP-level socket to configure the subflows until the subflow
>> +	 * is in TCP fallback, when TCP socket options are passed through
>> +	 * to the one remaining subflow.
>>  	 */
>>  	lock_sock(sk);
>> -	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
>> -	if (IS_ERR(ssock)) {
>> +	ssock =3D __mptcp_tcp_fallback(msk);
>> +	if (ssock) {
>> +		struct sock *ssk =3D ssock->sk;
>> +		int ret;
>> +
>> +		sock_hold(ssk);
>>  		release_sock(sk);
>> +		ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
>> +		sock_put(ssk);
>>  		return ret;
>>  	}
>>
>> -	ssk =3D ssock->sk;
>> -	sock_hold(ssk);
>>  	release_sock(sk);
>>
>> -	ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
>> -	sock_put(ssk);
>> -
>> -	return ret;
>> +	return -EOPNOTSUPP;
>>  }
>>
>>  static int mptcp_getsockopt(struct sock *sk, int level, int optname,
>>  			    char __user *optval, int __user *option)
>>  {
>>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> -	int ret =3D -EOPNOTSUPP;
>>  	struct socket *ssock;
>> -	struct sock *ssk;
>>
>>  	pr_debug("msk=3D%p", msk);
>>
>> -	/* @@ the meaning of getsockopt() when the socket is connected and
>> -	 * there are multiple subflows is not defined.
>> +	/* @@ the meaning of setsockopt() when the socket is connected and
>> +	 * there are multiple subflows is not yet defined. It is up to the
>> +	 * MPTCP-level socket to configure the subflows until the subflow
>> +	 * is in TCP fallback, when socket options are passed through
>> +	 * to the one remaining subflow.
>>  	 */
>>  	lock_sock(sk);
>> -	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
>> -	if (IS_ERR(ssock)) {
>> +	ssock =3D __mptcp_tcp_fallback(msk);
>> +	if (ssock) {
>> +		struct sock *ssk =3D ssock->sk;
>> +		int ret;
>> +
>> +		sock_hold(ssk);
>>  		release_sock(sk);
>
> Since I can't wrap my head on it, I'm going to do ask dumb question:
>

I think it's a good question!

> do we need this refcont at all? (here, in poll and in {recv,send}msg) ?
>
> AFAICS:
> - subflows can be freed only by mptcp_close()

This is true now, but Florian's patch that removed __mptcp_close() is =

fairly recent. I think the branch I was working from when I got concerned =

about the subflow lifetimes didn't have the change yet, so I the idea in =

my head that there were other paths to the subflow-freeing code that =

relied only on the MPTCP socket lock.

> - mptcp_close() is called by vfs->release() when the last reference to
> the file descriptor associated to the msk socket is dropped.
> - every syscall wraps vfs ops with fdget()/fdput() pairs so the file
> descriptor can't go away during the syscall execution.

While I saw that the MPTCP socket lifetime was managed with fdget/fdput, I =

couldn't track down such protections for the subflow socket structures =

because (as I now see) we're depending on the MPTCP-level socket reference =

count for that.

>
> Overall I think the race between mptcp_close() and sock_sendmsg() is
> not possible, WDYT ?!?

For single subflow, it does seem safe to me now that it's clear when =

mptcp_close is called. I'll drop the fallback changes outside of the =

sockopt functions and send the one sockopt patch to netdev.

>
> mptcp_close should need to care of possible cuncurrent BH/receive path
> processing.
>

Seems like the struct sock reference counts should handle that?

>
> Note: the I this doubt since I was wondering why socket-releated inet_*
> operations that do not acquire the sock lock still do not have any
> issue racing with close().

I'm glad you looked in to it. I was wondering the same thing when I saw =

the lack of fdget/fdput on the "struct socket" for subflows but didn't see =

that those were only freed when the entire MPTCP socket was being torn =

down.

--
Mat Martineau
Intel
--===============5378996217187316326==--
