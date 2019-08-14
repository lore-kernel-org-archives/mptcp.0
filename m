Content-Type: multipart/mixed; boundary="===============6797065296666637470=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 14th of August 2019
Date: Wed, 14 Aug 2019 19:20:40 +0200
Message-ID: <c88a416a-d7c6-6e27-f3fb-f3071ab51d49@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1639

--===============6797065296666637470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 62nd meeting with Mat (Intel OTC), Paolo and Florian
(RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: new sysctl to control the activation per NS:
        - by Matthieu
        - reviewed by Ossama, Peter
        - accepted by Peter
        - new patch added at the end

    - Implement outgoing MP_JOIN:
        - patch-set (10 patches) by Peter
        - reviewed by Paolo and Mat
        - Accepted by Paolo
        - Note: Mat had a comment on the 8th patch, Peter created a new
patch for that: mptcp: Add sock_put() call on error path
        - "squashed" in different commits (see ML) and two new patches
added at the end

    - Rename lookup_token() to __token_lookup:
        - by Peter
        - 3 patches
        - Mat accepted it
        - "squashed" in 3 different commits

    - mptcp: Add sock_put() call on error path:
        - by Peter
        - fixing an issue reported by Mat (accepted by Mat then)
        - "squashed" in one commit



Pending patches:
    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
        - by Mat
        - Mat has sent a new version (2 August)
        - Waiting for reviews (especially regarding the new flags and
other modifications)

    - mptcp: Implement interim path manager:
        - by Peter
        - RFC
        - waiting for review / (or new version with sysctl?)
        - Matth: I can help if needed
        - Matth: TODO: can share a block of code to read addresses, etc.
sysctl stuff



Roadmap:
    - Paolo is looking at updating msk data_ack (at different times:
sendmsg time but it is not enough, it seems we need an MPTCP timer for
that to walk across all subflows to update the ACK and report this to
the msk)

    - How to deal with sending queue: we send over one subflow, we might
have to retransmit the data (from one to another subflow). Maybe easier
to copy the skb each time we move from one queue to another (per
connection / per subflow), or only retransmit when a subflow is down
(and copy at that moment). Would be good to retransmit fragments.

    - for sendmsg, it can block, we need to manage this case

    - Could be good to discuss about that with Christoph to have some
feedback from the design choices made in mptcp.org

    - Paolo saw an memory error path when doing TCP retransmission.
Should be investigated

    - what should we retransmit after a RTO: single SKB like TCP (and
mptcp.org)?

    - Paolo can share code that describes that (not fully working code)

    - Paolo: protocol.c is getting bigger and bigger. Could be good to
split in output/input like it is done in TCP (and mptcp.org)

    - We could do the same for protocol.h



LPC:
    - Paper (2 to 10 pages):
        - Read only: https://www.overleaf.com/read/thprgxkdxxwg
        - For the read-write link, please send an email to Matt

    - Presentation: for later

    - Discussed last time: would be nice to talk about:
        - the diff with mptcp.org
        - diff between now and the initial merge
        - future (roadmap, can change be to give an idea)
        - take into account the feedback we got from Netconf
        - We can take slides from
http://vger.kernel.org/netconf2019_files/FlorianWestphal_netconf2019.pdf

    - More a standalone presentation, many people would not remember or
would not know about the previous presentations netconf/netdev 0x12

    - we should ask questions there:
        - about what should be in the next RFC we will send to netdev
        - about IPPROTO_MPTCP
        - anything we are think we need to ask for advices
        - @all: feel free to contribute to this list!

    - Plan:
        - next week (22nd): put the structure in the paper
        - week after (29th): we will in the sections
        - week after (5th): we have the structure for the presentation,
only details about animations / others are left for the end of the week

    - MPTCP outline (by Mat)
        * MPTCP Quick Protocol Overview
             * v0 versus v1
             * Coupled rx window
        * MPTCP & Linux: History
             * Brief multipath-tcp.org kernel and design philosophy overview
             * Already upstream
                 * skb_ext
             * RFC patch set published to netdev June 2019
                 * Stats on this code
        * Roadmap: Initial merge
             * Don't affect TCP. Keep existing performance, don't
introduce new bugs. Opt in to MPTCP for each connection.
             * RFC 6824 (bis?) compliance
                 * Comply with the musts, but limit implementation of
optional features, advanced tuning, and optimizations
                 * DSS checksum off by default
                     * Can we skip checksum support by always falling
back to TCP if checksum required by peer?
                 * TCP fallback
             * Interface
                 * IPPROTO_MPTCP
                 * MPTCP-level socket with each subflow mapping to an
additional TCP socket within the kernel. ULP utilized between subflows
and their associated MPTCP socket
             * IPv4 and IPv6
             * Pick one congestion control algorithm for all subflows
(TCP one, no need to discuss about MPTCP ones (coupled CC))
                 * Hard code for MPTCP?
                 * Separate config in /proc for MPTCP congestion control?
             * "Server" usage
                 * Remote peer initiates connections and additional subflows
                 * Simple policy for subflows (limit to 2-3 subflows?)
                 * Simple tx scheduling: Honor "backup" flag from remote
peer, otherwise send on subflow last received from (?)
                 * Send ADD_ADDR / REMOVE_ADDR?
                 * Close MPTCP connection if all subflows close if this
simplifies implementation
                 * Monitoring with socket diag/ss
                 * Self tests
                 * (What will be in /proc or sysfs for MPTCP?)
             * Some optional TCP features may not work in TCP subflows
                 * Fast open?
             * Feature phase-in
                 * CONFIG_MPTCP off by default
                 * (?) For initial version, require elevated privileges
to enable system-wide or to create MPTCP socket
        * Roadmap: Advanced features
             * Userspace path manager
                 * mptcpd: https://github.com/intel/mptcpd/
                 * netlink API
                 * Compatibility between multipath-tcp.org and upstream API
                 * Most beneficial to peers originating connections/subflows
             * In-kernel path manager optimizations for servers
                 * Frequent operations happen in kernel space rather
than triggering lots of netlink activity
             * Tx Packet scheduling
                 * eBPF?
             * cgroup eBPF hook to allow unmodified userspace programs
to use MPTCP
                 * Change socket() call proto to IPPROTO_MPTCP within a
cgroup
             * Performance optimizations
                 * Gather data and address hot spots
                 * Reassembly and retransmission
                     * Consider which subflows have already sent
specific data when retransmitting
                 * Fast open
             * Break-before-make
                 * Keep MPTCP-level connection alive for some time after
all subflows are closed to allow a time period for new subflows to be
established
             * Socket options for per-subflow information and configuration
             * kTLS
                 * Would require ULP implementation on top of MPTCP
socket and MPTCP-specific hooks
                 * TLS on MPTCP could benefit from aligning TLS records
with DSS segments, may be needed for hardware TLS anyway
                     * Can TLS accelerators handle not seeing every record?



Next meeting:
    - We propose to have it next Thursday, the 22nd of August.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190822



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you next week,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6797065296666637470==--
