Content-Type: multipart/mixed; boundary="===============6790327449717487494=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Signed-off-by: add the ones of the sender
Date: Fri, 17 Jan 2020 17:28:46 +0100
Message-ID: <a2c845a3-9113-5e7c-d903-75969ff41c59@tessares.net>
In-Reply-To: 51122759-4e6f-1410-44d1-620e1e0a4520@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3395

--===============6790327449717487494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 13/12/2019 16:06, Matthieu Baerts wrote:
> Hi,
> =

> FYI, I just added Mat and Christoph' signed-off at the end in all =

> patches where the sender is not the author.
> =

> Mat' signed-off:
> =

> t/tcp-clean-ext-on-tx-recycle d0a53799b41b
> t/skb-add-helpers-to-allocate-ext-independently-from-sk_buff 49657b530937
> t/mptcp-Handle-MPTCP-TCP-options 7dcbde272d8d
> t/mptcp-Associate-MPTCP-context-with-TCP-socket 77bc072d50bb
> t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections fa30eb93af07
> t/mptcp-Create-SUBFLOW-socket-for-incoming-connections 6aeb1ed9011b
> t/mptcp-Add-key-generation-and-token-tree 51937718ddb0
> t/mptcp-Add-shutdown-socket-operation 54fb2be27f3f
> t/mptcp-Add-setsockopt-getsockopt-socket-operations 408d02d51c75
> t/mptcp-add-subflow-write-space-signalling-and-mptcp_poll 688e4e89051c
> t/mptcp-recvmsg-can-drain-data-from-multiple-subflows 1a2a035ade5c
> t/mptcp-allow-collapsing-consecutive-sendpages-on-the-same-substream =

> 86d9099d23ae
> t/mptcp-new-sysctl-to-control-the-activation-per-NS e95682b4a686
> t/mptcp-add-basic-kselftest-for-mptcp 254904819820
> =

> Christoph' signed-off:
> =

> t/mptcp-move-from-sha1-v0-to-sha256-v1 76bdd7c23334

I just added Christoph' signed-off for the whole part 2 (and removed Mat =

when needed)

t/mptcp-Add-MPTCP-socket-stubs 6fc97b496ddb
t/mptcp-Handle-MPTCP-TCP-options 29bc9f92358c
t/mptcp-Associate-MPTCP-context-with-TCP-socket f8fc982dff1e
t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections 486969ba72ed
t/mptcp-Create-SUBFLOW-socket-for-incoming-connections 0ca8ad65f908
t/mptcp-Add-key-generation-and-token-tree 136a39892507
t/mptcp-Add-shutdown-socket-operation 919041a5b757
t/mptcp-Add-setsockopt-getsockopt-socket-operations 89a20f0dcec9
t/mptcp-Write-MPTCP-DSS-headers-to-outgoing-data-packets a0c2e26ba010
t/mptcp-Implement-MPTCP-receive-path 0407b2f68a91
t/mptcp-add-subflow-write-space-signalling-and-mptcp_poll 0f68dd73e570
t/mptcp-recvmsg-can-drain-data-from-multiple-subflows 2c353e180796
t/mptcp-allow-collapsing-consecutive-sendpages-on-the-same-substream =

bfd1a2285cfb
t/mptcp-new-sysctl-to-control-the-activation-per-NS 31c9ec8fce82
t/mptcp-add-basic-kselftest-for-mptcp ca7ac12a5753

The rest (previous part 3) was already done.

A new version of the "export" branch has just been published.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6790327449717487494==--
