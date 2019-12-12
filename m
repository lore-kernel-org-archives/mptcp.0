Content-Type: multipart/mixed; boundary="===============3419716065648236494=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove request_version field from
 subflow_request_sock
Date: Thu, 12 Dec 2019 23:14:45 +0100
Message-ID: <797c5d6f-e1ae-05db-8701-d118e8845b7c@tessares.net>
In-Reply-To: 330403f5-48da-bdcb-cae7-027773d25982@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2897

--===============3419716065648236494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo

On 12/12/2019 23:11, Matthieu Baerts wrote:
> Hi Peter, Paolo,
> =

> On 12/12/2019 05:54, Peter Krystad wrote:
>> Since only a single version is supported this fields presence
>> is misleading, it dates from when it was thought the version would
>> be configurable. The actual requested version is hard-coded in
>> mptcp_write_options().
>>
>> squashto: Associate MPTCP context with TCP socket
> =

> Thank you for the patch and the review!

- a63d1cdb5903: "squashed" in "mptcp: Associate MPTCP context with TCP =

socket"
- 053bccb0ca21: conflict in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- b9a183bde93e: conflict in =

t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
- e081b82c8850: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- d2dba972de89..55f1d621d32b: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3419716065648236494==--
