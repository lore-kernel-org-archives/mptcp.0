Content-Type: multipart/mixed; boundary="===============9178094401901852511=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] protocol questions
Date: Tue, 24 Sep 2019 09:03:38 +0200
Message-ID: <0d0552da75d1cdea03ac789df684b50a5fd96b54.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1910

--===============9178094401901852511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

there are a few DSS related corner cases I don't understand well:

* is support for 'delayed DSS' optional? e.g. pkt 1 with no DSS, pkt 2
with DSS for pkt 1 and 2. Can we ignore/consider such scenario evil
(and ev close the subflow if we hit it)?

* are out-of-order DSS allowed? I mean pkt 1 contans a DSS for pkt 2
and vice-versa? If I read correctly, the RFC does not explicitly forbit
them. Can we consider such scenario evil (and ev close the subflow if
we hit it)?

* what if we receive a different DSS before the old one is completed?
If I read the RFC correctly, that should be allowed only if the new DSS
don't change the existing mapping - e.g. the DSS lenght grow and
anything else is unchanged. How we should handle other scenario? ignore
the DSS? close the subflow? as MPTCP processing happens after TCP
validation, I suppose TCP reset should fit here.

Thanks,

Paolo


--===============9178094401901852511==--
