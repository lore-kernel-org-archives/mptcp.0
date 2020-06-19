Content-Type: multipart/mixed; boundary="===============1310262656935635343=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] selftests/mptcp: Capture pcap on both
 sender and receiver
Date: Fri, 19 Jun 2020 17:28:17 +0200
Message-ID: <f8bd76bc-2f26-04d8-b742-7f882f7e977c@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2006182051191.19717@adhawale-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4754

--===============1310262656935635343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Christoph,

On 19/06/2020 05:52, Mat Martineau wrote:
> =

> On Tue, 16 Jun 2020, Matthieu Baerts wrote:
> =

>> When investigating performance issues that involve
>> latency/loss/reordering it is useful to have the pcap from the
>> sender-side as it allows to easier infer the state of the sender's
>> congestion-control, loss-recovery,...
>>
>> Allow the selftests to capture a pcap on both sides so that this
>> information is not lost when reproducing.
>>
>> This patch also improves the file names. Instead of:
>>
>> =C2=A0ns4-5ee79a56-X4O6gS-ns3-5ee79a56-X4O6gS-MPTCP-MPTCP-10.0.3.1.pcap
>>
>> We now have something like:
>>
>> =C2=A05ee79a56-X4O6gS-ns3-ns4-MPTCP-MPTCP-10.0.3.1-10030-connector.pcap
>> =C2=A05ee79a56-X4O6gS-ns3-ns4-MPTCP-MPTCP-10.0.3.1-10030-listener.pcap
>>
>> It was a connection from ns3 to ns4, better to start with ns3 then. The
>> port is also added, easier to find the trace we want.

(...)

> =

> Nice improvement for the capture feature - looks ready to merge!

Thank you for the review and the patch!

Just added at the end of the series (before the two DO-NOT-MERGE patches)

- a4c3a82f66d9: selftests/mptcp: Capture pcap on both sender and receiver

Tests will be launched soon.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1310262656935635343==--
