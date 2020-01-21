Content-Type: multipart/mixed; boundary="===============5730003352354079954=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: cope with later TCP fallback"
Date: Tue, 21 Jan 2020 23:13:24 +0100
Message-ID: <02e36edc-bee5-d34e-69b3-8910795fdc96@tessares.net>
In-Reply-To: f1b14c29e7ccf456d0316203db679a9641f8f91b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3461

--===============5730003352354079954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 21/01/2020 21:40, Paolo Abeni wrote:
> On Tue, 2020-01-21 at 18:20 +0100, Matthieu Baerts wrote:
>> Hi Paolo, Mat,
>>
>> On 21/01/2020 17:32, Paolo Abeni wrote:
>>> kbuildbot reported a build breakage with IPV6 disabled.
>>
>> Do you know why my CI didn't get the issue?
>>
>> It runs:
>>
>>     make defconfig
>>     echo | scripts/config -d (...) ## to disable DRM, SOUND, USB, etc.
>>     echo | scripts/config -e MPTCP -e MPTCP_IPV6
>>     echo | scripts/config -d IPV6 -d MPTCP_IPV6
>>     make
>>
>> MPTCP is enabled and IPV6 is not.
>>
>> Which combination did I miss?
> =

> weird. I can reproduce the build failure with
> =

> CONFIG_MPTCP=3Dy
> # CONFIG_IPV6 is not set
> # CONFIG_MPTCP_IPV6 is not set
> =

> =

> net/mptcp/protocol.o: In function `__mptcp_fallback_to_tcp':
> /home/pabeni/linux-net/net/mptcp/protocol.c:63: undefined reference to
> `inet6_stream_ops'
> =

> the inet6_stream_ops struct is unconditionally referenced by the mptcp
> code.

I don't understand why but my CI didn't catch errors when compiling =

without IPv6 :-/

Here is the script I use:

 =

https://github.com/multipath-tcp/mptcp_net-next/blob/d77caf0c96ed3825c6c750=
445a7a5e772da27477/ci/update-tg-tree.sh#L278


And here is what I have in the logs:



+ tg checkout next
+ break
+ is_tg_top t/upstream
+ '[' t/upstream =3D t/upstream ']'
+ check_compilation_no_ipv6
+ generate_config_mptcp
+ generate_config_no_mptcp
+ make defconfig
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
+ echo
+ scripts/config --disable DRM --disable PCCARD --disable ATA --disable =

MD --disable PPS --disable SOUND --disable USB --disable IOMMU_SUPPORT =

--disable INPUT_LEDS --disable AGP --disable VGA_ARB --disable EFI =

--disable WLAN --disable WIRELESS --disable LOGO --disable NFS_FS =

--disable XFRM_USER --disable INET6_AH --disable INET6_ESP --disable =

NETDEVICES
+ echo
+ scripts/config -e MPTCP -e MPTCP_IPV6
+ echo
+ scripts/config -d IPV6 -d MPTCP_IPV6
+ compile_kernel 'without IPv6 and with CONFIG_MPTCP'
++ nproc
++ nproc
+ KCFLAGS=3D-Werror
+ make -j8 -l8
scripts/kconfig/conf  --syncconfig Kconfig
   DESCEND  objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h

[...]

   CC      net/mptcp/protocol.o
   CC      net/mptcp/subflow.o
   CC      kernel/sched/pelt.o
   CC      kernel/sched/stats.o
   CC      kernel/auditfilter.o
   CC      net/core/dev_ioctl.o
   CC      kernel/sched/cpuacct.o
   CC      net/ipv4/tcp_ulp.o
net/mptcp/protocol.c: In function 'mptcp_copy_inaddrs':
net/mptcp/protocol.c:1133:21: error: unused variable 'msk6' =

[-Werror=3Dunused-variable]
   struct ipv6_pinfo *msk6 =3D inet6_sk(msk);
                      ^~~~
net/mptcp/protocol.c:1132:27: error: unused variable 'ssk6' =

[-Werror=3Dunused-variable]
   const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
                            ^~~~
cc1: all warnings being treated as errors
scripts/Makefile.build:265: recipe for target 'net/mptcp/protocol.o' failed
make[2]: *** [net/mptcp/protocol.o] Error 1
make[2]: *** Waiting for unfinished jobs....
   CC      net/ipv4/tcp_offload.o
   CC      net/ipv4/datagram.o
scripts/Makefile.build:503: recipe for target 'net/mptcp' failed
make[1]: *** [net/mptcp] Error 2
make[1]: *** Waiting for unfinished jobs....
   CC      net/ipv4/raw.o

[...]

   AR      net/ipv4/built-in.a
make: *** [net] Error 2
Makefile:1693: recipe for target 'net' failed
+ err 'Unable to compile without IPv6 and with CONFIG_MPTCP'
+ echo 'ERROR: Unable to compile without IPv6 and with CONFIG_MPTCP'
ERROR: Unable to compile without IPv6 and with CONFIG_MPTCP
+ return 1
+ return 1
+ check_compilation_i386

[...]


I have no idea why "check_compilation_i386" is executed while "set -e" =

is launched at the beginning of the script (even set by the caller: =

"bash -ehxB patches/update-tg-tree.sh") and it should prevent that.

If you have any idea why, I would be very interested by the explanation :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5730003352354079954==--
