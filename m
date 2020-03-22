Content-Type: multipart/mixed; boundary="===============1269555062225339725=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Preparing to send "part 3" - cover letter draft
Date: Sun, 22 Mar 2020 19:52:00 +0100
Message-ID: <42a4326090db4c356a549f2e42c342ab4bf1c4d8.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2003201452520.22025@nkathuri-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4039

--===============1269555062225339725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-20 at 15:03 -0700, Mat Martineau wrote:
> Here's my draft for the cover letter.
> =

> Paolo, is the path manager part correct? Anything I should add there?
> =

> Note that I proposed "netdev-v1-for-5.6" for the tag because there's an =

> existing "netdev-v1-part3" tag, although that "part 3" patch set was neve=
r =

> sent to netdev (it was combined with the part 2 posting) - we can use the =

> v1-part3 tag if people prefer that.
> =

> =

> """
> Multipath TCP: Multiple subflows and path management
> =

> This patch set allows more than one TCP subflow to be established and use=
d =

> for a multipath TCP connection. Subflows are added to an existing =

> connection using the MP_JOIN option during the 3-way handshake. With =

> multiple TCP subflows available, sent data is now stored in the MPTCP =

> socket so it may be retransmitted on any TCP subflow if there is no =

> DATA_ACK before a timeout. If an MPTCP-level timeout occurs, data is =

> retransmitted using an available subflow. Storing this sent data requires =

> the addition of memory accounting at the MPTCP level, which was previousl=
y =

> delegated to the single subflow. Incoming DATA_ACKs now free data from th=
e =

> MPTCP-level retransmit buffer.
> =

> IP addresses available for new subflow connections can now be advertised =

> and received with the ADD_ADDR option, and the corresponding REMOVE_ADDR =

> option likewise advertises that an address is no longer available.
> =

> The MPTCP path manager netlink interface has commands to set in-kernel =

> limits for the number of concurrent subflows and control the advertisemen=
t =

> of IP addresses between peers.

LGTM.

Eventually we can a little more details, replacing the last part ("and
control the advertisement of IP addresses between peers." with
something alike:


"""
, specify additional local addresses to be used for additional subflows
and control the advertisement of IP addresses between peers.
"""

Thanks,

Paolo

--===============1269555062225339725==--
