Content-Type: multipart/mixed; boundary="===============7232300567211496085=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Android phones with MPTCP
Date: Fri, 13 Nov 2020 17:47:39 +0100
Message-ID: <4b5ec789-12d2-f161-a4a2-2e5b362f1106@tessares.net>
In-Reply-To: CAOenT2MTUxcorJ5bQ1w0OSoMTG_AiJ2GDpgSejPRHJ9jPW1j2w@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6722

--===============7232300567211496085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marios,

On 12/11/2020 18:15, Marios Choudary wrote:
> Could you please help me with a list of Android smartphones that support =

> MPTCP ?

This project is about MPTCP in the upstream Linux kernel. The work is in =

progress and the inclusion started in Linux 5.6. It is a rework of a =

fork that was started a few years ago. More details in our wiki:

https://github.com/multipath-tcp/mptcp_net-next/wiki

You then need to find a phone using a kernel >=3D5.6

> I would prefer to know about recent models, either Samsung or Google =

> Pixel, but if there is some comprehensive list that would be great as wel=
l.

To my knowledge, most recent phones are using a kernel 4.19 or older. In =

Android, they are usually using the LTS version. The next ones are v5.4 =

and v5.10.

Also I heard that at Linaro, they have a project to use the mainstream =

kernel:

https://www.linaro.org/blog/aosp-on-pixel3-pocof1-running-aosp-with-mainlin=
e-kernel-on-form-factor-devices/


If you are interested by the out-of-tree kernel (mptcp.org), another =

company should release a kernel with MPTCP (fork) for the PocoF1. No =

idea when.
One last thing, some phones have MPTCP support (Apple, some Samsung, =

Huawei, LG, etc.). For the Android ones, you certainly need extra =

permissions to be able to use MPTCP and configure it. I don't have a =

list for that, you need to check the source code of their kernel to see =

if the folder "net/mptcp" exists.

If you have questions about that, the best is to ask them on the ML =

linked to this other project:

mptcp-dev(a)listes.uclouvain.be
http://multipath-tcp.org/

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7232300567211496085==--
