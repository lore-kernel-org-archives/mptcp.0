Content-Type: multipart/mixed; boundary="===============8732108928901057032=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Add DATA_FIN transmission and handling
Date: Fri, 08 Nov 2019 16:02:21 +0100
Message-ID: <7fcd5297-be1f-03a4-0118-5dd498fd6b71@tessares.net>
In-Reply-To: 20191106045011.10071-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2443

--===============8732108928901057032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 06/11/2019 05:50, Mat Martineau wrote:
> Send and process received DATA_FIN options. This requires addition of a
> state machine to the MPTCP socket to handle the closing process. DATA_FIN
> is sent along with a DSS mapping for the final data transmitted, or on a
> bare ACK if there is no data to transmit.
> =

> This is still a work in progress, including these areas:
> =

>   * Need to finish handling of DSS_ACKs for the state machine.
> =

>   * Need to double-check whether it's correct to bypass inet_shutdown
>     as the current code does.
> =

>   * A DATA_FIN that arrives on a packet without data payload (unless it's
>     a TCP FIN) are discarded by tcp_data_queue() and not propagated to
>     the MPTCP socket. This is detected in mptcp_incoming_options() but
>     not yet handled. The skb with the DATA_FIN could be cloned and
>     placed in the subflow error queue, or a workqueue could handle it.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Yesterday at the meeting we talked a bit about this patch. Here is what =

we said:


     - DATA_FIN:
         - Mat is working on it
         - It seems still to be too big for the "initial submission" =

with the minimal feature
         - because sending the DATA_FIN might be required for some =

implementations (not closing the MPTCP connections), it could be good to =

at least send the DATA_FIN, without the full support.

         - *Mat*: maybe for the initial submission, part 2, where only 1 =

subflow is supported, could we send the DATA_FIN just before closing the =

connection? With the minimal support.


What do you think about that?

Cheers and take care,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8732108928901057032==--
