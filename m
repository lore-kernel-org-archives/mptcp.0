Content-Type: multipart/mixed; boundary="===============5383593216243581581=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp] net: mptcp: don't leak 'slab' and
 'slab_name' on exit
Date: Wed, 22 May 2019 14:57:19 -0700
Message-ID: <alpine.OSX.2.21.1905221405110.28292@cwhilton-mobl1.amr.corp.intel.com>
In-Reply-To: 6d0d38d80ff98b971af747a51f69bbb7748cf8dd.1558555611.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1227

--===============5383593216243581581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 22 May 2019, Davide Caratti wrote:

> fix leak of subflows' slab and slab_name in the (rare) case where
> proto_register(mptcp_prot, 1) returns -ENOBUFS.

Thanks for fixing these leaks, Davide. One comment below:

>
> Fixes: e203b1359cf77 ("mptcp: Associate MPTCP context with TCP socket")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/subflow.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index bc8e1a0658ec..f93c6d4d7172 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -318,6 +318,8 @@ int subflow_init(void)
> void subflow_exit(void)
> {
> 	tcp_unregister_ulp(&subflow_ulp_ops);
> +	kmem_cache_destroy(subflow_request_sock_ops.slab);
> +	kfree(subflow_request_sock_ops.slab_name);

Looking at where slab_name is allocated, kmem_cache_create() can take a =

pointer to an rodata string. If subflow_request_sock_ops.slab_name were =

set using a string literal instead of kasprintf(), we would save a couple =

of unnecessary allocations the new kfree() would not be needed.


Mat


> }
>
> MODULE_LICENSE("GPL");
> -- =

> 2.20.1
>

--
Mat Martineau
Intel

--===============5383593216243581581==--
