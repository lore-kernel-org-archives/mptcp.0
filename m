Content-Type: multipart/mixed; boundary="===============1909543299671473899=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] selftests/mptcp: Capture pcap on both
 sender and receiver
Date: Tue, 16 Jun 2020 18:06:52 +0200
Message-ID: <2a39ec06-e67f-bfa2-d159-e1b287274cc1@tessares.net>
In-Reply-To: 20200616154924.17949-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 4703

--===============1909543299671473899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 16/06/2020 17:49, Christoph Paasch wrote:
> When investigating performance issues that involve
> latency/loss/reordering it is useful to have the pcap from the
> sender-side as it allows to easier infer the state of the sender's
> congestion-control, loss-recovery,...
> =

> Allow the selftests to capture a pcap on both sides so that this
> information is not lost when reproducing.

Thank you for the patch!

I was going to send the same! (because you requested to have this =

capture :) )
Below you can find the difference with what I did:

> =

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>   tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index acf02e156d20..faf636d1639f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -386,9 +386,11 @@ do_transfer()
>   		fi
>   =

>   		local capfile=3D"${listener_ns}-${connector_ns}-${cl_proto}-${srv_pro=
to}-${connect_addr}.pcap"
> -
>   		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuse=
r -w $capfile > "$capout" 2>&1 &
> -		local cappid=3D$!
> +		local cappid_listener=3D$!
> +		local capfile=3D"${connector_ns}-${listener_ns}-${cl_proto}-${srv_prot=
o}-${connect_addr}.pcap"

detail: Here you don't need "local", capfile is already declared as local.

Would it not be better to have the same name but ending with -listener =

or -connector?

In my patch, I did that:


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D < =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -395,10 +395,13 @@ do_transfer()
                         capuser=3D"-Z $SUDO_USER"
                 fi

-               local =

capfile=3D"${listener_ns}-${connector_ns}-${cl_proto}-${srv_proto}-${connec=
t_addr}.pcap"
+               local =

capfile=3D"${rndh}-${listener_ns:0:3}-${connector_ns:0:3}-${cl_proto}-${srv=
_proto}-${connect_addr}"

-               ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B =

32768 $capuser -w $capfile > "$capout" 2>&1 &
-               local cappid=3D$!
+               ip netns exec ${listener_ns}  tcpdump -i any -s 65535 -B =

32768 ${capuser} -w "${capfile}_listener.pcap"  >> "${capout}" 2>&1 &
+               local cappid_listener=3D$!
+
+               ip netns exec ${connector_ns} tcpdump -i any -s 65535 -B =

32768 ${capuser} -w "${capfile}_connector.pcap" >> "${capout}" 2>&1 &
+               local cappid_connector=3D$!

                 sleep 1
         fi
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D < =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I shorted listener_ns and connector_ns to only 3 chars: "nsX"

Now that I am thinking about that it would even make more sense with =

"connector_ns" first as it is what we display in the output (the printf =

above):

capfile=3D"${rndh}-${connector_ns0:3}-${listener_ns::0:3}-${cl_proto}-${srv=
_proto}-${connect_addr}"

WDYT?

> +		ip netns exec ${connector_ns} tcpdump -i any -s 65535 -B 32768 $capuse=
r -w $capfile > "$capout" 2>&1 &

The output should append ${capout} I guess, not to override the previous =

one:

   >> "${capout}"

(but the output is somehow annoying in fact but that's another issue :) )

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1909543299671473899==--
