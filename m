Content-Type: multipart/mixed; boundary="===============8680775450116282739=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp] net: mptcp: don't leak 'slab' and
 'slab_name' on exit
Date: Thu, 23 May 2019 14:03:28 +0200
Message-ID: <ed9e82f7102cf723ed7791071573d6a28616814a.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1905221405110.28292@cwhilton-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1230

--===============8680775450116282739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello Mat, thanks for looking at this!

On Wed, 2019-05-22 at 14:57 -0700, Mat Martineau wrote:
> On Wed, 22 May 2019, Davide Caratti wrote:
> =

> Looking at where slab_name is allocated, kmem_cache_create() can take a =

> pointer to an rodata string. If subflow_request_sock_ops.slab_name were =

> set using a string literal instead of kasprintf(), we would save a couple =

> of unnecessary allocations the new kfree() would not be needed.

you are right, I will send a v2 in short time.

regards,
-- =

davide



--===============8680775450116282739==--
