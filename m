Content-Type: multipart/mixed; boundary="===============7962459233745649377=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 0/3] MP_JOIN handling WIP
Date: Fri, 14 Jun 2019 17:05:45 +0200
Message-ID: <ce1c0bfa-89e1-47ab-7059-33e69b6627c3@tessares.net>
In-Reply-To: 20190612232127.3647-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1378

--===============7962459233745649377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 13/06/2019 01:21, Peter Krystad wrote:
> Current state of MP_JOIN handling. As I mentioned this is not
> functional yet but am sharing for visibility. The intent of this
> patchset is to complete the handshake for a second subflow in the
> incoming direction. Sending an outgoing SYN with MP_JOIN and the
> data path is not addressed.
> =

> v2 - pr_debug() cleanup and single mptcp_established() hook were
>      address in other already-merged patchsets
>    - split path manager skeleton into its own commit
>    - cleaned up logic in subflow_syn_recv_sock
>    - rebase onto Florian's locking change
>    - namespace for token table NOT addressed
> =

> Peter Krystad (3):
>   mptcp: Add path manager interface
>   mptcp: Add ADD_ADDR handling
>   mptcp: Add handling of incoming MP_JOIN requests

Thank you for the patches and the review!

I added these 3 patches at the end but I also took the liberty to:

- move new TCPOLEN macros from include/net/tcp.h to net/mptcp/protocol.h

- apply this patch (50cab8858b7f) in "mptcp: Add handling of incoming
MP_JOIN requests" to fix a compilation error when CONFIG_MPTCP was not used.

    -static inline boo*k* mptcp_sk_is_subflow(const struct sock *sk)
    +static inline boo*l* mptcp_sk_is_subflow(const struct sock *sk)

Apparently there is no book called mptcp_sk_is_subflow() yet, maybe a
good idea of name ;-)

I just re-ran the tests with these new patches and this time, I have an
error with KASAN and PROVE_LOCKING, same as the one I saw a few hours ago:


00:19:46.711 # ns1  MPTCP -> ns3  (10.0.2.2:10010) TCP  	[ OK ]
00:19:48.368 # ns1  TCP   -> ns3  (10.0.2.2:10011) MPTCP	[ OK ]
00:19:49.865 # ns1  MPTCP -> ns3  (10.0.3.2:10012) MPTCP	main_loop_s:
timed out
00:20:20.940 # copyfd_io: poll timed out (events: POLLIN 1, POLLOUT 4)
00:20:20.943 # [ FAIL ] client exit code 2, server 2
00:20:20.943 # \nnetns ns3 socket stat for 10012:
00:20:21.081 # State     Recv-Q   Send-Q        Local Address:Port
  Peer Address:Port
00:20:21.082 # SYN-RECV  0        0                  10.0.3.2:10012
      10.0.1.1:39530    timer:(on,990ms,4) cwnd:2 retrans:4/0 reordering:0
00:20:21.086 # \nnetns ns1 socket stat for 10012:
00:20:21.130 # State       Recv-Q   Send-Q      Local Address:Port
  Peer Address:Port
00:20:21.130 # FIN-WAIT-1  0        57345            10.0.1.1:39530
      10.0.3.2:10012    timer:(on,21sec,7) rto:25.72 cwnd:1 ssthresh:7
retrans:7/0 reordering:0
00:20:21.146 # ns1  MPTCP -> ns4  (10.0.3.1:10013) MPTCP	[ OK ]
00:20:26.032 # ns1  MPTCP -> ns4  (10.0.3.1:10014) TCP  	[ OK ]

But for the rest, the other tests are good.

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7962459233745649377==--
