Content-Type: multipart/mixed; boundary="===============0968850823750856845=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Feedback to the IETF
Date: Wed, 20 Nov 2019 10:15:30 +0100
Message-ID: <d6709bbe368539bacf2edbc5d30a15f3866125ad.camel@redhat.com>
In-Reply-To: 9DF9C238-3239-496B-A229-423477DD767A@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2606

--===============0968850823750856845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-20 at 15:52 +0800, Christoph Paasch wrote:
> So, let me try to compile a list of things that came up. Please correct o=
r add anything:

Thank you for doing this!

> Clarifying that the reception of a DATA_ACK means that the server
> successfully received the MP_CAPABLE (Text "If B has data to send
> first, then the reliable delivery of the ACK can be inferred by the
> receipt of this data with an MPTCP DATA_ACK inside the DSS option
> (Section 3.3).)

Ack! :) Plus perhaps stating explicitly that client CAN send DSS
instead of MP_CAPABLE + data len after the above.

> Should we vouch to disallow early or late DSS mappings that are
> covering a TCP-sequence space different than the packet they are
> being sent on (cfr., our discussion on/around September 25th)

+1, this will simplify and clean-up the implementation, and I do not
see benefit from supporting such mappings.

> ADD_ADDR-option size - last  week we discussed this briefly and I
> replied by mail that the size-problem is actually for the non-Echo
> option. In that one there is no way to get around it and all the bits
> need to be presented. Do you agree on that?

Sorry for the lack of feedback. I originally misread the RFC the other
way, but the text is actually very clear.

To be 110% honest, I don't see why HMAC is needed here, assuming
ADD_ADDR comes after MP_JOIN/MP_CAPABLE, we already authenticated both
peers, and if an attacker can inject malicious TCP packets inside the
stream we are at loss no matter what.

Thanks,

Paolo


--===============0968850823750856845==--
