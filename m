Content-Type: multipart/mixed; boundary="===============5227152733583659141=="
MIME-Version: 1.0
From: Randy Dunlap <rdunlap at infradead.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: mmotm 2020-01-28-20-05 uploaded (net/mptcp/subflow.c)
Date: Tue, 28 Jan 2020 20:39:03 -0800
Message-ID: <71437ed1-e8b6-83bc-04b2-4c82fb313370@infradead.org>
In-Reply-To: 20200129040640.6PNuz0vcp%akpm@linux-foundation.org
X-Status: 
X-Keywords:                  
X-UID: 3549

--===============5227152733583659141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 1/28/20 8:06 PM, akpm(a)linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-01-28-20-05 has been uploaded to
> =

>    http://www.ozlabs.org/~akpm/mmotm/
> =

> mmotm-readme.txt says
> =

> README for mm-of-the-moment:
> =

> http://www.ozlabs.org/~akpm/mmotm/
> =

> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> =


Lots of build errors when CONFIG_PROC_FS is not set/enabled:

(truncation of around 500 lines of errors & warnings:)

In file included from ../include/asm-generic/percpu.h:7:0,
                 from ../arch/x86/include/asm/percpu.h:556,
                 from ../arch/x86/include/asm/preempt.h:6,
                 from ../include/linux/preempt.h:78,
                 from ../include/linux/spinlock.h:51,
                 from ../include/linux/seqlock.h:36,
                 from ../include/linux/time.h:6,
                 from ../include/linux/stat.h:19,
                 from ../include/linux/module.h:13,
                 from ../net/mptcp/subflow.c:10:
../net/mptcp/subflow.c: In function =E2=80=98mptcp_subflow_create_socket=E2=
=80=99:
../net/mptcp/subflow.c:624:25: error: =E2=80=98struct netns_core=E2=80=99 h=
as no member named =E2=80=98sock_inuse=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
                         ^
../include/linux/percpu-defs.h:219:47: note: in definition of macro =E2=80=
=98__verify_pcpu_ptr=E2=80=99
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                               ^~~
../include/linux/percpu-defs.h:509:33: note: in expansion of macro =E2=80=
=98__pcpu_size_call=E2=80=99
 #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
                                 ^~~~~~~~~~~~~~~~
../net/mptcp/subflow.c:624:2: note: in expansion of macro =E2=80=98this_cpu=
_add=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
  ^~~~~~~~~~~~
../net/mptcp/subflow.c:624:25: error: =E2=80=98struct netns_core=E2=80=99 h=
as no member named =E2=80=98sock_inuse=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
                         ^
../include/linux/percpu-defs.h:376:16: note: in definition of macro =E2=80=
=98__pcpu_size_call=E2=80=99
  switch(sizeof(variable)) {     \
                ^~~~~~~~
../net/mptcp/subflow.c:624:2: note: in expansion of macro =E2=80=98this_cpu=
_add=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
  ^~~~~~~~~~~~
In file included from ../arch/x86/include/asm/preempt.h:6:0,
                 from ../include/linux/preempt.h:78,
                 from ../include/linux/spinlock.h:51,
                 from ../include/linux/seqlock.h:36,
                 from ../include/linux/time.h:6,
                 from ../include/linux/stat.h:19,
                 from ../include/linux/module.h:13,
                 from ../net/mptcp/subflow.c:10:
../net/mptcp/subflow.c:624:25: error: =E2=80=98struct netns_core=E2=80=99 h=
as no member named =E2=80=98sock_inuse=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
                         ^
../arch/x86/include/asm/percpu.h:129:17: note: in definition of macro =E2=
=80=98percpu_add_op=E2=80=99
  typedef typeof(var) pao_T__;     \
                 ^~~
../include/linux/percpu-defs.h:377:11: note: in expansion of macro =E2=80=
=98this_cpu_add_1=E2=80=99
   case 1: stem##1(variable, __VA_ARGS__);break;  \
           ^~~~
../include/linux/percpu-defs.h:509:33: note: in expansion of macro =E2=80=
=98__pcpu_size_call=E2=80=99
 #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
                                 ^~~~~~~~~~~~~~~~
../net/mptcp/subflow.c:624:2: note: in expansion of macro =E2=80=98this_cpu=
_add=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
  ^~~~~~~~~~~~
../net/mptcp/subflow.c:624:25: error: =E2=80=98struct netns_core=E2=80=99 h=
as no member named =E2=80=98sock_inuse=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
                         ^
../arch/x86/include/asm/percpu.h:138:17: note: in definition of macro =E2=
=80=98percpu_add_op=E2=80=99
  switch (sizeof(var)) {      \
                 ^~~
../include/linux/percpu-defs.h:377:11: note: in expansion of macro =E2=80=
=98this_cpu_add_1=E2=80=99
   case 1: stem##1(variable, __VA_ARGS__);break;  \
           ^~~~
../include/linux/percpu-defs.h:509:33: note: in expansion of macro =E2=80=
=98__pcpu_size_call=E2=80=99
 #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
                                 ^~~~~~~~~~~~~~~~
../net/mptcp/subflow.c:624:2: note: in expansion of macro =E2=80=98this_cpu=
_add=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
  ^~~~~~~~~~~~
../net/mptcp/subflow.c:624:25: error: =E2=80=98struct netns_core=E2=80=99 h=
as no member named =E2=80=98sock_inuse=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
                         ^
../arch/x86/include/asm/percpu.h:141:45: note: in definition of macro =E2=
=80=98percpu_add_op=E2=80=99
    asm qual ("incb "__percpu_arg(0) : "+m" (var)); \
                                             ^~~
../include/linux/percpu-defs.h:377:11: note: in expansion of macro =E2=80=
=98this_cpu_add_1=E2=80=99
   case 1: stem##1(variable, __VA_ARGS__);break;  \
           ^~~~
../include/linux/percpu-defs.h:509:33: note: in expansion of macro =E2=80=
=98__pcpu_size_call=E2=80=99
 #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
                                 ^~~~~~~~~~~~~~~~
../net/mptcp/subflow.c:624:2: note: in expansion of macro =E2=80=98this_cpu=
_add=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
  ^~~~~~~~~~~~
../net/mptcp/subflow.c:624:25: error: =E2=80=98struct netns_core=E2=80=99 h=
as no member named =E2=80=98sock_inuse=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
                         ^
../arch/x86/include/asm/percpu.h:143:45: note: in definition of macro =E2=
=80=98percpu_add_op=E2=80=99
    asm qual ("decb "__percpu_arg(0) : "+m" (var)); \
                                             ^~~
../include/linux/percpu-defs.h:377:11: note: in expansion of macro =E2=80=
=98this_cpu_add_1=E2=80=99
   case 1: stem##1(variable, __VA_ARGS__);break;  \
           ^~~~
../include/linux/percpu-defs.h:509:33: note: in expansion of macro =E2=80=
=98__pcpu_size_call=E2=80=99
 #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
                                 ^~~~~~~~~~~~~~~~
../net/mptcp/subflow.c:624:2: note: in expansion of macro =E2=80=98this_cpu=
_add=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
  ^~~~~~~~~~~~
../net/mptcp/subflow.c:624:25: error: =E2=80=98struct netns_core=E2=80=99 h=
as no member named =E2=80=98sock_inuse=E2=80=99
  this_cpu_add(*net->core.sock_inuse, 1);
                         ^




-- =

~Randy
Reported-by: Randy Dunlap <rdunlap(a)infradead.org>
--===============5227152733583659141==--
