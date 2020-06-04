Content-Type: multipart/mixed; boundary="===============5346409713815679609=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] inet_connection_sock: clear inet_num out of
 destroy helper
Date: Thu, 04 Jun 2020 10:43:52 -0700
Message-ID: <5b3af1f4-c1f4-5f60-21e0-9b52f186f328@gmail.com>
In-Reply-To: cc2adbd7dcc17c44e2858e550302906760b38a0b.1591289527.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4592

--===============5346409713815679609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 6/4/20 9:55 AM, Paolo Abeni wrote:
> Clearing the 'inet_num' field is necessary and safe if and
> only if the socket is not bound. The MPTCP protocol calls
> the destroy helper on bound sockets, as tcp_v{4,6}_syn_recv_sock
> completed successfully.
> =

> Move the clearing of such field out of the common code, otherwise
> the MPTCP MP_JOIN error path will find the wrong 'inet_num' value
> on socket disposal, __inet_put_port() will acquire the wrong lock
> and bind_node removal could race with other modifiers possibly
> corrupting the bind hash table.
> =

> Reported-and-tested-by: Christoph Paasch <cpaasch(a)apple.com>
> Fixes: 729cd6436f35 ("mptcp: cope better with MP_JOIN failure")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet(a)google.com>

Thanks.

--===============5346409713815679609==--
