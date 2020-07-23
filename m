Content-Type: multipart/mixed; boundary="===============3481619544472196766=="
MIME-Version: 1.0
From: Eric Dumazet <edumazet at google.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 04/26] net: add a new sockptr_t type
Date: Thu, 23 Jul 2020 09:40:27 -0700
Message-ID: <CANn89iJ3LKth-iWwh0+P3D3RqtDNv4AyXkkzhXr0oSEvE_JoRQ@mail.gmail.com>
In-Reply-To: 20200723060908.50081-5-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5253

--===============3481619544472196766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:09 PM Christoph Hellwig <hch(a)lst.de> wrote:
>
> Add a uptr_t type that can hold a pointer to either a user or kernel
> memory region, and simply helpers to copy to and from it.
>
> Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> ---
>  include/linux/sockptr.h | 104 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 include/linux/sockptr.h
>
> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
> new file mode 100644
> index 00000000000000..700856e13ea0c4
> --- /dev/null
> +++ b/include/linux/sockptr.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 Christoph Hellwig.
> + *
> + * Support for "universal" pointers that can point to either kernel or u=
serspace
> + * memory.
> + */
> +#ifndef _LINUX_SOCKPTR_H
> +#define _LINUX_SOCKPTR_H
> +
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +typedef struct {
> +       union {
> +               void            *kernel;
> +               void __user     *user;
> +       };
> +       bool            is_kernel : 1;
> +} sockptr_t;
>

I am not sure why you chose sockptr_t   for something that really seems gen=
eric.

Or is it really meant to be exclusive to setsockopt() and/or getsockopt() ?

If the first user of this had been futex code, we would have used
futexptr_t, I guess.
--===============3481619544472196766==--
