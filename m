Content-Type: multipart/mixed; boundary="===============6272013622562785092=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove version field from
 subflow_request_sock
Date: Fri, 13 Dec 2019 01:21:23 +0100
Message-ID: <b4349852-1fee-6cdd-612e-a4ba695c7e18@tessares.net>
In-Reply-To: 436ce10c-a798-7994-98f5-afc297b56c90@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2910

--===============6272013622562785092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 12/12/2019 23:29, Matthieu Baerts wrote:
> Hi Peter, Paolo,
> =

> On 12/12/2019 05:55, Peter Krystad wrote:
>> This field is not used. Version checking is performed in
>> mptcp_parse_options().
>>
>> squashto: Create SUBFLOW socket for incoming connections
> =

> Thank you for the patch and the review!
> =

> - 24201a067136: "squashed" in "mptcp: Create SUBFLOW socket for incoming =

> connections"
> - 222ce475568a: conflict in t/mptcp-Add-key-generation-and-token-tree
> - 3f97d6a7010d: conflict in =

> t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
> - bc5f2367d3e2: conflict in t/mptcp-process-MP_CAPABLE-data-option
> - bc5f2367d3e2: conflict in t/mptcp-process-MP_CAPABLE-data-option
> - 55f1d621d32b..c5b8ad49fc3a: result

I went a bit too fast on this one:

- 78b5742651e0: mptcp: fix wrong merge conflict resolution
- 0b89eccbe98a: conflict in t/mptcp-Add-path-manager-interface
- 357e47f49334..45cba5f6b369: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6272013622562785092==--
