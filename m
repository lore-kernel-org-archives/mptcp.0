Content-Type: multipart/mixed; boundary="===============1584193086831906628=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Protect subflow socket options before
 connection completes
Date: Mon, 10 Feb 2020 16:44:48 -0800
Message-ID: <alpine.OSX.2.22.394.2002101636290.9189@mjmartin-mac01.local>
In-Reply-To: 1d1027e176351e99937a2d9089d213a5b60c38d8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3610

--===============1584193086831906628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2020, Paolo Abeni wrote:

> On Mon, 2020-02-10 at 12:52 +0100, Florian Westphal wrote:
>> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>> Userspace should not be able to directly manipulate subflow socket
>>> options before a connection is established since it is not yet known if
>>> it will be an MPTCP subflow or a TCP fallback subflow. TCP fallback
>>> subflows can be more directly controlled by userspace because they are
>>> regular TCP connections, while MPTCP subflow sockets need to be
>>> configured for the specific needs of MPTCP. Use the same logic as
>>> sendmsg/recvmsg to ensure that socket option calls are only passed
>>> through to known TCP fallback subflows.
>>>
>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>> ---
>>>
>>> One other question: is it racy to have __mptcp_tcp_fallback() return an
>>> unlocked msk, then do the sock_hold(ssk) from an unlocked state?
>>
>> Yes.
>>
>>> It seems like if holding the ssk reference count is necessary at all it
>>> should be done while the msk is still locked. I'm considering a change
>>> to __mptcp_tcp_fallback() to have it not release the msk lock and
>>> instead have all the callers do that.
>>
>> Yes, that seems like the right thing to do.
>
> Agreed.
>
> I think that a separate patch for the above would be nicer.
>

Thanks Florian and Paolo. It's clear what to do when handling struct sock =

reference counts, but we are also using struct socket in two different =

ways:

  * Calling sock_{send,recv}msg() without the msk lock (because we don't =

want to keep it locked while the subflow call blocks).

  * Calling ssock->ops->poll. The msk lock is held, but mptcp_close is =

closing subflow sockets without the msk lock, and since we're reaching the =

subflow without using conn_list it looks like it's possible to have the =

subflow struct socket unexpectedly freed.

I have a patch in progress but haven't addressed these last two issues =

yet.

--
Mat Martineau
Intel
--===============1584193086831906628==--
