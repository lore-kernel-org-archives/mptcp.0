Content-Type: multipart/mixed; boundary="===============7670307699390856812=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 9/9] don't flag parent socket as RCV_SHUTDOWN
 if one one subflow has closed
Date: Tue, 03 Dec 2019 08:44:52 +0100
Message-ID: <9684c074-f270-cafc-79c4-232cc94bd4f0@tessares.net>
In-Reply-To: f1841522df592649acb43542ac41fcbdf3da618d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2757

--===============7670307699390856812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo, Mat,

On 02/12/2019 22:21, Paolo Abeni wrote:
> On Mon, 2019-12-02 at 20:10 +0100, Florian Westphal wrote:

[...]

> Thanks for addressing my comments.
> =

> With 9/9 v2 the series is IMHO ready to me merged.

Thank you for the nice patch series and the reviews!
Related to what we discussed yesterday, is it OK if I merge this after:

  1) DATA_FIN
  2) MPTCPv1 =E2=86=92 wait a bit for a review
  3) SendMsg "refactor" =E2=86=92 if reviewed

Or can I do that after the patches for MPTCPv1 if the patches to fix =

sendmsg() have not been reviewed yet?

Also just to be sure: do I squash the 2 first ones and then I add the =

rest at the end of the series?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7670307699390856812==--
