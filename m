Content-Type: multipart/mixed; boundary="===============2472795791591506067=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Questions about DSS checksum
Date: Tue, 23 Feb 2021 17:55:40 +0100
Message-ID: <28bf8079-ae7e-26af-539a-7d3f7d20647c@tessares.net>
In-Reply-To: CA+WQbwuOcOWiHWtwsVU2r-K2P7jGpbL-q8sBH1juGwBki7gpzQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7923

--===============2472795791591506067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 23/02/2021 13:29, Geliang Tang wrote:
> In order to solve the issues 134, I'm reading the mptcp.org (branch:
> mptcp_v0.95) source code about DSS checksum implementation recently but I
> didn't understand it very well.

Thank you for looking at this!

> Here's my first question.

(...)

> On the incoming path (net/mptcp/mptcp_input.c), the function
> mptcp_parse_options, use the following code to parse MPTCP_SUB_DSS:

(...)

> Here it just sets the MPTCPHDR_DSS_CSUM flag, it doesn't read the checksum
> value from the DSS option.

Indeed, that's correct. Here, we only checks that for the current =

option, space has been reserved for the checksum.

> So my first question is: How dose it read the value
> of the checksum in DSS option on the incoming path?

We need to verify two things:
  (A) if the checksum has been negotiated, it should be present in all =

packets.
  (B) the checksum, if there, should be valid.

The MPTCPHDR_DSS_CSUM is used for the validation path. In this path, we =

have:

   -> tcp_rcv_established()
   -> or tcp_rcv_state_process()
     -> tcp_validate_incoming()
       -> mptcp_handle_options()

There, we only check if we were expecting a checksum for the connection =

(mpcb->dss_csum) and if it was there (MPTCPHDR_DSS_CSUM) as expected. =

That's linked to point (A) above.

We only have to do that because when packets are coming, we walk through =

the received queue and check if each received packet has the correct =

checksum, linked to (B):

   -> sk_data_ready()
     -> mptcp_data_ready()
       -> mptcp_queue_skb()
         -> mptcp_verif_dss_csum()

There, the csum is computed and verified using functions from =

skb_checksum and others, similar to what is done with TCP. For that =

specific part, I have to admit it has not been modified for years and I =

would have to study the SKB checksum API.


Note that as you might have seen in mptcp.org code, when the csum is =

needed, we have to disable some optimisations (sg, sendpage). With the =

DSS, we can aggregate packets if they are following each others but for =

the checksum, we first need to validate the checksum. I think it is best =

to disable some optimisations first if we need support checksum. Then =

look later to re-enable them if there is a need. Checksum has a =

performance impact anyway.

I hope this will help and I didn't say wrong stuff :-)
Don't hesitate to tell me if needed!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2472795791591506067==--
