Content-Type: multipart/mixed; boundary="===============0645820361652490526=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] docs: networking: mptcp: Add MPTCP
 sysctl entries
Date: Tue, 03 Nov 2020 10:22:40 +0100
Message-ID: <f1b44785-2654-4cca-2bd5-9c80f4db7b1d@tessares.net>
In-Reply-To: 20201103015542.16615-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6520

--===============0645820361652490526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 03/11/2020 02:55, Mat Martineau wrote:
> Describe the two MPTCP sysctls, what the values mean, and the default
> settings.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
> =

> Jakub requested sysctl documentation for the 'add_addr_timeout' setting,
> and we didn't have our 'enabled' sysctl documented either.

Thanks for looking after this!

> If this looks good to everyone I can add it to v2 the miscellaneous
> series on the netdev list.

Good idea! I just have one remark below!

(...)

> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/ne=
tworking/mptcp-sysctl.rst
> new file mode 100644
> index 000000000000..70c076eb361d
> --- /dev/null
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -0,0 +1,24 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +MPTCP Sysfs variables
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The "s" at the end is going to fall :-/

More seriously, if I am not mistaken, it is important to have at least =

the same amount of characters for the mark representing the title in RST.

There are some RST validators or maybe try this: http://rst.ninjs.org

> +/proc/sys/net/mptcp/* Variables:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Same here: one "=3D" is missing.

Note that for me, it is strange to add a ":" at the end of a title. They =

don't do that in ip-sysctl.rst but they do that in mpls-sysctl.rst. =

Personally, I would not add it.

Should we give a very short introduction about MPTCP here? I guess not =

in this "-sysctl" file. Later when we will have a documentation for =

userspace.

> +enabled - INTEGER
> +	Control whether MPTCP sockets can be created.

Should we mention this?

   This is a per-namespace sysctl.

For me, that's a very useful thing to know but often missing in the doc.

> +	MPTCP sockets can be created if the value is nonzero.
> +
> +	Default: 1
> +
> +add_addr_timeout - INTEGER (seconds)
> +	Set the timeout after which an ADD_ADDR control message will be
> +	resent to an MPTCP peer that has not acknowledged a previous
> +	ADD_ADDR message.

Here too, it is per-ns. I guess it would be good to repeat that for each =

sysctl. But because all of them are per-ns, we can also add something in =

the introduction, just under "/proc/sys/net/mptcp/* Variables". Up to you!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0645820361652490526==--
