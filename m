Content-Type: multipart/mixed; boundary="===============5839464642186153668=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] LPC 2019 - MPTCP outline
Date: Tue, 13 Aug 2019 16:53:48 -0700
Message-ID: <alpine.OSX.2.21.1908131641210.13751@agilpin-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1637

--===============5839464642186153668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello everyone -

Here's my initial draft of the paper/presentation outline for our Plumbers =

session. All comments, additions, fixes, requests for clarification, etc. =

are welcome!


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
     * Don't affect TCP. Keep existing performance, don't introduce new =

bugs. Opt in to MPTCP for each connection.
     * RFC 6824 (bis?) compliance
         * Comply with the musts, but limit implementation of optional =

features, advanced tuning, and optimizations
         * DSS checksum off by default
             * Can we skip checksum support by always falling back to TCP =

if checksum required by peer?
         * TCP fallback
     * Interface
         * IPPROTO_MPTCP
         * MPTCP-level socket with each subflow mapping to an additional =

TCP socket within the kernel. ULP utilized between subflows and their =

associated MPTCP socket
     * IPv4 and IPv6
     * Pick one congestion control algorithm for all subflows
         * Hard code for MPTCP?
         * Separate config in /proc for MPTCP congestion control?
     * "Server" usage
         * Remote peer initiates connections and additional subflows
         * Simple policy for subflows (limit to 2-3 subflows?)
         * Simple tx scheduling: Honor "backup" flag from remote peer, =

otherwise send on subflow last received from (?)
         * Send ADD_ADDR / REMOVE_ADDR?
         * Close MPTCP connection if all subflows close if this simplifies =

implementation
         * Monitoring with socket diag/ss
         * Self tests
         * (What will be in /proc or sysfs for MPTCP?)
     * Some optional TCP features may not work in TCP subflows
         * Fast open?
     * Feature phase-in
         * CONFIG_MPTCP off by default
         * (?) For initial version, require elevated privileges to enable =

system-wide or to create MPTCP socket
* Roadmap: Advanced features
     * Userspace path manager
         * mptcpd: https://github.com/intel/mptcpd/
         * netlink API
         * Compatibility between multipath-tcp.org and upstream API
         * Most beneficial to peers originating connections/subflows
     * In-kernel path manager optimizations for servers
         * Frequent operations happen in kernel space rather than =

triggering lots of netlink activity
     * Tx Packet scheduling
         * eBPF?
     * cgroup eBPF hook to allow unmodified userspace programs to use MPTCP
         * Change socket() call proto to IPPROTO_MPTCP within a cgroup
     * Performance optimizations
         * Gather data and address hot spots
         * Reassembly and retransmission
             * Consider which subflows have already sent specific data when =

retransmitting
         * Fast open
     * Break-before-make
         * Keep MPTCP-level connection alive for some time after all =

subflows are closed to allow a time period for new subflows to be =

established
     * Socket options for per-subflow information and configuration
     * kTLS
         * Would require ULP implementation on top of MPTCP socket and =

MPTCP-specific hooks
         * TLS on MPTCP could benefit from aligning TLS records with DSS =

segments, may be needed for hardware TLS anyway
             * Can TLS accelerators handle not seeing every record?

--
Mat Martineau
Intel

--===============5839464642186153668==--
