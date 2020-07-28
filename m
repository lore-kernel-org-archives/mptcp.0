Content-Type: multipart/mixed; boundary="===============6904607265691435442=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v4 08/12] mptcp: Use full MPTCP-level
 disconnect state machine
Date: Tue, 28 Jul 2020 15:15:08 -0700
Message-ID: <alpine.OSX.2.23.453.2007281514270.45676@joses-mobl6.amr.corp.intel.com>
In-Reply-To: 20200724011127.363638-9-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5356

--===============6904607265691435442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 23 Jul 2020, Mat Martineau wrote:

> RFC 8684 appendix D describes the connection state machine for
> MPTCP. This patch implements the DATA_FIN / DATA_ACK exchanges and
> MPTCP-level socket state changes described in that appendix, rather than
> simply sending DATA_FIN along with TCP FIN when disconnecting subflows.
>
> DATA_FIN is now sent and acknowledged before shutting down the
> subflows. Received DATA_FIN information (if not part of a data packet)
> is written to the MPTCP socket when the incoming DSS option is parsed by
> the subflow, and the MPTCP worker is scheduled to process the
> flag. DATA_FIN received as part of a full DSS mapping will be handled
> when the mapping is processed.
>
> The DATA_FIN is acknowledged by the worker if the reader is caught
> up. If there is still data to be moved to the MPTCP-level queue, ack_seq
> will be incremented to account for the DATA_FIN when it reaches the end
> of the stream and a DATA_ACK will be sent to the peer.
>
> In this RFC patch, DATA_FIN is sent when calling shutdown(fd, SHUT_WR)
> on the MPTCP socket. mptcp_close() has not yet been updated to wait for
> the peer to DATA_ACK before forcing all the subflows to be closed and
> cleaned up. The handshake is working with both peers using test programs
> with shutdown() and delays, but is not yet working consistently with the
> self tests. It also doesn't currently detect if fallback has happened,
> so there are extra acks sent on fallback connections.
>

Oops, this last paragraph was a holdover from the RFCv1 patch on this =

list. I deleted it before sending to netdev.

--
Mat Martineau
Intel
--===============6904607265691435442==--
